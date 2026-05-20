import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static const _keyUsername = 'username';
  static const _keyCart = 'cart_ids';
  static const _keyPhoto = 'profile_photo';

  static Future<void> saveSession(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUsername, username);
  }

  static Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUsername);
  }

  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUsername);
  }

  
  static Future<List<int>> getCartIds() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_keyCart);
    if (raw == null) return [];
    return List<int>.from(json.decode(raw));
  }

  static Future<void> addToCart(int productId) async {
    final prefs = await SharedPreferences.getInstance();
    final ids = await getCartIds();
    if (!ids.contains(productId)) {
      ids.add(productId);
      await prefs.setString(_keyCart, json.encode(ids));
    }
  }

  static Future<void> removeFromCart(int productId) async {
    final prefs = await SharedPreferences.getInstance();
    final ids = await getCartIds();
    ids.remove(productId);
    await prefs.setString(_keyCart, json.encode(ids));
  }

  static Future<bool> isInCart(int productId) async {
    final ids = await getCartIds();
    return ids.contains(productId);
  }


  static Future<void> savePhotoPath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyPhoto, path);
  }

  static Future<String?> getPhotoPath() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyPhoto);
  }
}
