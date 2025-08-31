import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FavoritesController extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;

  // 🧠 **تحسين 1: استخدام `Set` بدلاً من `List<Map>`**
  // الـ Set يوفر سرعة بحث O(1) (فورية تقريباً) باستخدام .contains()،
  // وهو أفضل بكثير من البحث في List الذي له سرعة O(n).
  // هذا يجعل دالة isFavorite أسرع وأكثر كفاءة.
  Set<int> _favoriteProductIds = {};

  // Getter عام وآمن للوصول إلى المفضلة من الواجهات الرسومية
  Set<int> get favoriteProductIds => _favoriteProductIds;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  RealtimeChannel? _favoritesChannel;

  FavoritesController() {
    _initialize();
  }

  // دالة لتهيئة الحالة وجلب البيانات الأولية والاشتراك في التغييرات
  Future<void> _initialize() async {
    try {
      if (_supabase.auth.currentUser == null) {
        // لا تقم بأي شيء إذا لم يكن المستخدم مسجلاً دخوله
        _isLoading = false;
        notifyListeners();
        return;
      }

      // 1. جلب البيانات الأولية عند بدء التشغيل
      final userId = _supabase.auth.currentUser!.id;
      final response = await _supabase.from('favorites').select('product_id').eq('user_id', userId);

      // تحويل البيانات المستلمة إلى Set of integers
      _favoriteProductIds = response.map<int>((item) => item['product_id'] as int).toSet();

      // 2. 🚀 **تحسين 2: الاشتراك في التغييرات الحية (Realtime)**
      // نستمع لأي إضافة أو حذف يحدث في جدول favorites الخاص بالمستخدم الحالي
      _listenToChanges(userId);
    } catch (e) {
      _error = "حدث خطأ أثناء جلب المفضلة: $e";
      debugPrint(_error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _listenToChanges(String userId) {
    // نحدد القناة والجدول والفلترة بناءً على user_id
    _favoritesChannel = _supabase
        .channel('public:favorites:user_id=eq.$userId')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          callback: (callback) {
            // عند إضافة عنصر جديد في قاعدة البيانات، نضيفه محلياً
            final newProductId = callback.newRecord['product_id'] as int;
            _favoriteProductIds.add(newProductId);
            notifyListeners();
          },
        )
        .onPostgresChanges(
          event: PostgresChangeEvent.delete,
          callback: (callback) {
            // عند حذف عنصر من قاعدة البيانات، نحذفه محلياً
            // نستخدم oldRecord لأن newRecord سيكون فارغاً في حالة الحذف
            final deletedProductId = callback.oldRecord['product_id'] as int;
            _favoriteProductIds.remove(deletedProductId);
            notifyListeners();
          },
        )
        .subscribe();
  }

  // ⚡ **تحسين 3: التحديث الفوري المحلي (Optimistic UI)**
  Future<void> addFavorite(int productId) async {
    // الخطوة 1: تحديث الواجهة فوراً (تفاؤلياً)
    _favoriteProductIds.add(productId);
    notifyListeners();

    try {
      // الخطوة 2: تنفيذ العملية على قاعدة البيانات في الخلفية
      await _supabase.from('favorites').insert({
        'product_id': productId,
        'user_id': _supabase.auth.currentUser!.id,
        'is_fave': true,
        // لا داعي لإضافة `is_fave`، وجود الصف يعني أنه مفضل
      });
    } catch (e) {
      // الخطوة 3: في حالة حدوث خطأ، يتم التراجع عن التغيير المحلي وإعلام المستخدم
      _favoriteProductIds.remove(productId);
      notifyListeners();
      debugPrint("خطأ في إضافة المفضلة: $e");
      // يمكنك هنا إظهار رسالة خطأ للمستخدم (e.g., using a snackbar)
    }
  }

  Future<void> removeFavorite(int productId) async {
    // الخطوة 1: تحديث الواجهة فوراً (تفاؤلياً)
    _favoriteProductIds.remove(productId);
    notifyListeners();

    try {
      // الخطوة 2: تنفيذ العملية على قاعدة البيانات في الخلفية
      await _supabase.from('favorites').delete().match({'product_id': productId, 'user_id': _supabase.auth.currentUser!.id});
    } catch (e) {
      // الخطوة 3: في حالة حدوث خطأ، يتم التراجع عن التغيير المحلي
      _favoriteProductIds.add(productId);
      notifyListeners();
      debugPrint("خطأ في حذف المفضلة: $e");
    }
  }

  // الآن هذه الدالة سريعة جداً بفضل استخدام Set
  bool isFavorite(int productId) {
    return _favoriteProductIds.contains(productId);
  }

  // 🧹 **تحسين 4: تنظيف الموارد عند عدم الحاجة**
  // من المهم جداً إلغاء الاشتراك عند حذف الـ Controller لمنع تسرب الذاكرة (memory leaks)
  @override
  void dispose() {
    _favoritesChannel?.unsubscribe();
    super.dispose();
  }
}
