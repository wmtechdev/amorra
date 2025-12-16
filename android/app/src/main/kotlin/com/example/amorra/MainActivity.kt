package com.example.amorra

import io.flutter.embedding.android.FlutterFragmentActivity

/**
 * MainActivity for Amorra App
 * 
 * IMPORTANT: This extends FlutterFragmentActivity (not FlutterActivity)
 * This is required for flutter_stripe package to work properly.
 * 
 * FlutterFragmentActivity is needed because Stripe Payment Sheet
 * requires fragment-based activities on Android.
 */
class MainActivity : FlutterFragmentActivity()
