import org.gradle.api.tasks.Delete
import org.gradle.api.Project
import org.gradle.api.initialization.dsl.ScriptHandler
import java.io.File

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}


val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.set(newBuildDir)

subprojects {
    layout.buildDirectory.set(newBuildDir.dir(name))
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
