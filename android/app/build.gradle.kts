import java.util.Properties
import java.io.FileInputStream
import java.io.FileOutputStream
import java.security.KeyStore

plugins {
    id("com.android.application")
    id("com.google.gms.google-services")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "nada.aya_packageappmarket"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    defaultConfig {
        applicationId = "nada.aya_packageappmarket"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    // ------------------ SIGNING CONFIG ------------------
    val keystorePropertiesFile = rootProject.file("key.properties")
    val keystoreProperties = Properties()
    if (keystorePropertiesFile.exists()) {
        keystoreProperties.load(FileInputStream(keystorePropertiesFile))
    }

    val keystoreFile = file("key_app.jks")

    // إنشاء keystore تلقائي إذا لم يكن موجود
    if (!keystoreFile.exists()) {
        println("Keystore not found, creating automatically...")
        val keyStore = KeyStore.getInstance("JKS")
        keyStore.load(null, null)
        keyStore.store(FileOutputStream(keystoreFile), "123456".toCharArray())
        println("Keystore created at: ${keystoreFile.absolutePath}")
    }

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties.getProperty("keyAlias") ?: "upload"
            keyPassword = keystoreProperties.getProperty("keyPassword") ?: "123456"
            storeFile = keystoreFile
            storePassword = keystoreProperties.getProperty("storePassword") ?: "123456"
        }
    }

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }
}

flutter {
    source = "../.."
}
