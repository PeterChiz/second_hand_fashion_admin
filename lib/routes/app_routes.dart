import 'package:get/get_navigation/src/routes/get_route.dart';

import '../features/authentication/screens/forget_password/forget_password.dart';
import '../features/authentication/screens/login/login.dart';
import '../features/authentication/screens/password_configuration/reset_password/reset_password.dart';
import '../features/media/screens/media/media.dart';
import '../features/shop/screens/banner/all_banners/banners.dart';
import '../features/shop/screens/banner/create_banner/create_banner.dart';
import '../features/shop/screens/banner/edit_banner/edit_banner.dart';
import '../features/shop/screens/brand/all_brands/brands.dart';
import '../features/shop/screens/brand/create_brand/create_brand.dart';
import '../features/shop/screens/brand/edit_brand/edit_brand.dart';
import '../features/shop/screens/category/all_categories/categories.dart';
import '../features/shop/screens/category/create_category/create_category.dart';
import '../features/shop/screens/category/edit_category/edit_category.dart';
import '../features/shop/screens/customer/all_customers/customers.dart';
import '../features/shop/screens/customer/customer_detail/customer.dart';
import '../features/shop/screens/dashboard/dashboard.dart';
import '../features/shop/screens/order/all_orders/orders.dart';
import '../features/shop/screens/order/orders_detail/order_detail.dart';
import '../features/shop/screens/product/all_products/products.dart';
import '../features/shop/screens/product/create_product/create_product.dart';
import '../features/shop/screens/product/edit_product/edit_product.dart';
import 'routes.dart';
import 'routes_middleware.dart';

class SHFAppRoute {
  static final List<GetPage> pages = [
    GetPage(name: SHFRoutes.login, page: () => const LoginScreen()),
    GetPage(
        name: SHFRoutes.forgetPassword,
        page: () => const ForgetPasswordScreen()),
    GetPage(
        name: SHFRoutes.resetPassword, page: () => const ResetPasswordScreen()),
    GetPage(
        name: SHFRoutes.dashboard,
        page: () => const DashboardScreen(),
        middlewares: [SHFRouteMiddleware()]),
    GetPage(
        name: SHFRoutes.media,
        page: () => const MediaScreen(),
        middlewares: [SHFRouteMiddleware()]),

    // Products
    GetPage(
        name: SHFRoutes.banners,
        page: () => const BannersScreen(),
        middlewares: [SHFRouteMiddleware()]),
    GetPage(
        name: SHFRoutes.createBanner,
        page: () => const CreateBannerScreen(),
        middlewares: [SHFRouteMiddleware()]),
    GetPage(
        name: SHFRoutes.editBanner,
        page: () => const EditBannerScreen(),
        middlewares: [SHFRouteMiddleware()]),

    // Products
    GetPage(
        name: SHFRoutes.products,
        page: () => const ProductsScreen(),
        middlewares: [SHFRouteMiddleware()]),
    GetPage(
        name: SHFRoutes.createProduct,
        page: () => const CreateProductScreen(),
        middlewares: [SHFRouteMiddleware()]),
    GetPage(
        name: SHFRoutes.editProduct,
        page: () => const EditProductScreen(),
        middlewares: [SHFRouteMiddleware()]),

    // Categories
    GetPage(
        name: SHFRoutes.categories,
        page: () => const CategoriesScreen(),
        middlewares: [SHFRouteMiddleware()]),
    GetPage(
        name: SHFRoutes.createCategory,
        page: () => const CreateCategoryScreen(),
        middlewares: [SHFRouteMiddleware()]),
    GetPage(
        name: SHFRoutes.editCategory,
        page: () => const EditCategoryScreen(),
        middlewares: [SHFRouteMiddleware()]),

    // Brands
    GetPage(
        name: SHFRoutes.brands,
        page: () => const BrandsScreen(),
        middlewares: [SHFRouteMiddleware()]),
    GetPage(
        name: SHFRoutes.createBrand,
        page: () => const CreateBrandScreen(),
        middlewares: [SHFRouteMiddleware()]),
    GetPage(
        name: SHFRoutes.editBrand,
        page: () => const EditBrandScreen(),
        middlewares: [SHFRouteMiddleware()]),

    // Customers
    GetPage(
        name: SHFRoutes.customers,
        page: () => const CustomersScreen(),
        middlewares: [SHFRouteMiddleware()]),
    GetPage(
        name: SHFRoutes.customerDetails,
        page: () => const CustomerDetailScreen(),
        middlewares: [SHFRouteMiddleware()]),

    // Orders
    GetPage(
        name: SHFRoutes.orders,
        page: () => const OrdersScreen(),
        middlewares: [SHFRouteMiddleware()]),
    GetPage(
        name: SHFRoutes.orderDetails,
        page: () => const OrderDetailScreen(),
        middlewares: [SHFRouteMiddleware()]),
  ];
}
