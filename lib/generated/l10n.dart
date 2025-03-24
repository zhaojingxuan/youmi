// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Me`
  String get main_mine {
    return Intl.message('Me', name: 'main_mine', desc: '', args: []);
  }

  /// `Store`
  String get main_store {
    return Intl.message('Store', name: 'main_store', desc: '', args: []);
  }

  /// `Discover`
  String get main_discover {
    return Intl.message('Discover', name: 'main_discover', desc: '', args: []);
  }

  /// `Shorts`
  String get main_shorts {
    return Intl.message('Shorts', name: 'main_shorts', desc: '', args: []);
  }

  /// `More`
  String get clip_more {
    return Intl.message('More', name: 'clip_more', desc: '', args: []);
  }

  /// `Less`
  String get clip_less {
    return Intl.message('Less', name: 'clip_less', desc: '', args: []);
  }

  /// `Watch Full Episodes`
  String get watch_full_episodes {
    return Intl.message(
      'Watch Full Episodes',
      name: 'watch_full_episodes',
      desc: '',
      args: [],
    );
  }

  /// `Anthology List`
  String get anthology_list {
    return Intl.message(
      'Anthology List',
      name: 'anthology_list',
      desc: '',
      args: [],
    );
  }

  /// `Unlock conditions:`
  String get unlock_conditions {
    return Intl.message(
      'Unlock conditions:',
      name: 'unlock_conditions',
      desc: '',
      args: [],
    );
  }

  /// `Coins`
  String get clip_coins {
    return Intl.message('Coins', name: 'clip_coins', desc: '', args: []);
  }

  /// `Watch ADs`
  String get watch_ads {
    return Intl.message('Watch ADs', name: 'watch_ads', desc: '', args: []);
  }

  /// `Energy`
  String get clip_vigor {
    return Intl.message('Energy', name: 'clip_vigor', desc: '', args: []);
  }

  /// `Enable Auto`
  String get enable_auto {
    return Intl.message('Enable Auto', name: 'enable_auto', desc: '', args: []);
  }

  /// `VIP Subscription Service`
  String get vip_subscription_service {
    return Intl.message(
      'VIP Subscription Service',
      name: 'vip_subscription_service',
      desc: '',
      args: [],
    );
  }

  /// `Limited Time Offer`
  String get limited_time_offer {
    return Intl.message(
      'Limited Time Offer',
      name: 'limited_time_offer',
      desc: '',
      args: [],
    );
  }

  /// `Prop Shop`
  String get prop_shop {
    return Intl.message('Prop Shop', name: 'prop_shop', desc: '', args: []);
  }

  /// `Top Up`
  String get top_up {
    return Intl.message('Top Up', name: 'top_up', desc: '', args: []);
  }

  /// `Warm Reminder`
  String get warm_reminder {
    return Intl.message(
      'Warm Reminder',
      name: 'warm_reminder',
      desc: '',
      args: [],
    );
  }

  /// `1.Payment: After the user confirms the purchase and pays, it is credited to the iTunes account.`
  String get payment_tips_1 {
    return Intl.message(
      '1.Payment: After the user confirms the purchase and pays, it is credited to the iTunes account.',
      name: 'payment_tips_1',
      desc: '',
      args: [],
    );
  }

  /// `2.Cancel the renewal: For the automatic renewal service, if you need to cancel the renewal, the user can manually turn off the automatic renewal function in iTunes/AppleID setup management at any time24 hours before the current subscription period expires, and the system will no longer deduct the fee after cancellation.`
  String get payment_tips_2 {
    return Intl.message(
      '2.Cancel the renewal: For the automatic renewal service, if you need to cancel the renewal, the user can manually turn off the automatic renewal function in iTunes/AppleID setup management at any time24 hours before the current subscription period expires, and the system will no longer deduct the fee after cancellation.',
      name: 'payment_tips_2',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get sign_in {
    return Intl.message('Sign In', name: 'sign_in', desc: '', args: []);
  }

  /// `History`
  String get history {
    return Intl.message('History', name: 'history', desc: '', args: []);
  }

  /// `Favorites`
  String get favorites {
    return Intl.message('Favorites', name: 'favorites', desc: '', args: []);
  }

  /// `Member`
  String get member {
    return Intl.message('Member', name: 'member', desc: '', args: []);
  }

  /// `Daily Check`
  String get daily_check {
    return Intl.message('Daily Check', name: 'daily_check', desc: '', args: []);
  }

  /// `Check in`
  String get check_in {
    return Intl.message('Check in', name: 'check_in', desc: '', args: []);
  }

  /// `Daily Task`
  String get daily_task {
    return Intl.message('Daily Task', name: 'daily_task', desc: '', args: []);
  }

  /// `To Do List`
  String get to_do_list {
    return Intl.message('To Do List', name: 'to_do_list', desc: '', args: []);
  }

  /// `Upgrade to Lv%1$s still needed %2$s XP`
  String get upgrade_to_lv_still_needed_xp {
    return Intl.message(
      'Upgrade to Lv%1\$s still needed %2\$s XP',
      name: 'upgrade_to_lv_still_needed_xp',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Google`
  String get login_with_google {
    return Intl.message(
      'Sign in with Google',
      name: 'login_with_google',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Facebook`
  String get login_with_facebook {
    return Intl.message(
      'Sign in with Facebook',
      name: 'login_with_facebook',
      desc: '',
      args: [],
    );
  }

  /// `If you continue,we will assume you have read and agreed to the following agreement`
  String get agreement_desc {
    return Intl.message(
      'If you continue,we will assume you have read and agreed to the following agreement',
      name: 'agreement_desc',
      desc: '',
      args: [],
    );
  }

  /// `User Agreement`
  String get user_agreement {
    return Intl.message(
      'User Agreement',
      name: 'user_agreement',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacy_policy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Help & Feedback`
  String get help_and_feedback {
    return Intl.message(
      'Help & Feedback',
      name: 'help_and_feedback',
      desc: '',
      args: [],
    );
  }

  /// `Affiliation`
  String get affiliation {
    return Intl.message('Affiliation', name: 'affiliation', desc: '', args: []);
  }

  /// `About`
  String get about {
    return Intl.message('About', name: 'about', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Automatically unlock`
  String get automatic_release {
    return Intl.message(
      'Automatically unlock',
      name: 'automatic_release',
      desc: '',
      args: [],
    );
  }

  /// `Account Cancellation`
  String get account_cancellation {
    return Intl.message(
      'Account Cancellation',
      name: 'account_cancellation',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get log_out {
    return Intl.message('Log Out', name: 'log_out', desc: '', args: []);
  }

  /// `Network Error`
  String get network_error {
    return Intl.message(
      'Network Error',
      name: 'network_error',
      desc: '',
      args: [],
    );
  }

  /// `check the network and try again`
  String get check_the_network_and_try_again {
    return Intl.message(
      'check the network and try again',
      name: 'check_the_network_and_try_again',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get try_again {
    return Intl.message('Try Again', name: 'try_again', desc: '', args: []);
  }

  /// `Like`
  String get like {
    return Intl.message('Like', name: 'like', desc: '', args: []);
  }

  /// `Collect`
  String get collect {
    return Intl.message('Collect', name: 'collect', desc: '', args: []);
  }

  /// `Day %d`
  String get day_format {
    return Intl.message('Day %d', name: 'day_format', desc: '', args: []);
  }

  /// `Day`
  String get day {
    return Intl.message('Day', name: 'day', desc: '', args: []);
  }

  /// `No more data`
  String get s_no_more {
    return Intl.message('No more data', name: 's_no_more', desc: '', args: []);
  }

  /// `EP.`
  String get clip_ep {
    return Intl.message('EP.', name: 'clip_ep', desc: '', args: []);
  }

  /// `Go`
  String get go {
    return Intl.message('Go', name: 'go', desc: '', args: []);
  }

  /// `Watch ads to unlocked for free`
  String get watch_ads_to_get_vigor_unlocked_for_free {
    return Intl.message(
      'Watch ads to unlocked for free',
      name: 'watch_ads_to_get_vigor_unlocked_for_free',
      desc: '',
      args: [],
    );
  }

  /// `Automatically use Coins unlock episodes`
  String get automatically_use_coins_unlock_episodes {
    return Intl.message(
      'Automatically use Coins unlock episodes',
      name: 'automatically_use_coins_unlock_episodes',
      desc: '',
      args: [],
    );
  }

  /// `Tips`
  String get tips {
    return Intl.message('Tips', name: 'tips', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `OK`
  String get ok {
    return Intl.message('OK', name: 'ok', desc: '', args: []);
  }

  /// `Are you sure to log out?`
  String get sure_to_log_out {
    return Intl.message(
      'Are you sure to log out?',
      name: 'sure_to_log_out',
      desc: '',
      args: [],
    );
  }

  /// `ClipDrama Hot`
  String get clip_drama_hot {
    return Intl.message(
      'ClipDrama Hot',
      name: 'clip_drama_hot',
      desc: '',
      args: [],
    );
  }

  /// `Get`
  String get clip_get {
    return Intl.message('Get', name: 'clip_get', desc: '', args: []);
  }

  /// `Complete`
  String get clip_complete {
    return Intl.message('Complete', name: 'clip_complete', desc: '', args: []);
  }

  /// `Earn more rewards`
  String get earn_more_rewards {
    return Intl.message(
      'Earn more rewards',
      name: 'earn_more_rewards',
      desc: '',
      args: [],
    );
  }

  /// `Deleting your account will permanently remove your content and subscriptions. If you wish to delete your account, please send an application email to us, and we will respond to you within 24 hours. Thank you for your support.`
  String get delete_account_tips {
    return Intl.message(
      'Deleting your account will permanently remove your content and subscriptions. If you wish to delete your account, please send an application email to us, and we will respond to you within 24 hours. Thank you for your support.',
      name: 'delete_account_tips',
      desc: '',
      args: [],
    );
  }

  /// `Sure`
  String get clip_sure {
    return Intl.message('Sure', name: 'clip_sure', desc: '', args: []);
  }

  /// `Please enter your email`
  String get please_enter_your_email {
    return Intl.message(
      'Please enter your email',
      name: 'please_enter_your_email',
      desc: '',
      args: [],
    );
  }

  /// `Not Ready`
  String get not_ready {
    return Intl.message('Not Ready', name: 'not_ready', desc: '', args: []);
  }

  /// `Email not Correct`
  String get email_format_error {
    return Intl.message(
      'Email not Correct',
      name: 'email_format_error',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations`
  String get congratulations {
    return Intl.message(
      'Congratulations',
      name: 'congratulations',
      desc: '',
      args: [],
    );
  }

  /// `Bill`
  String get bill {
    return Intl.message('Bill', name: 'bill', desc: '', args: []);
  }

  /// `Popular Now`
  String get popular_now {
    return Intl.message('Popular Now', name: 'popular_now', desc: '', args: []);
  }

  /// `Restore`
  String get clip_restore {
    return Intl.message('Restore', name: 'clip_restore', desc: '', args: []);
  }

  /// `Google Subscription Management`
  String get subs_management {
    return Intl.message(
      'Google Subscription Management',
      name: 'subs_management',
      desc: '',
      args: [],
    );
  }

  /// `If you want to manage your subscription, Please go to`
  String get subs_management_desc {
    return Intl.message(
      'If you want to manage your subscription, Please go to',
      name: 'subs_management_desc',
      desc: '',
      args: [],
    );
  }

  /// `Unlimited access to all series for 1 year`
  String get unlimited_access_year {
    return Intl.message(
      'Unlimited access to all series for 1 year',
      name: 'unlimited_access_year',
      desc: '',
      args: [],
    );
  }

  /// `Unlimited access to all series for 1 week`
  String get unlimited_access_weekly {
    return Intl.message(
      'Unlimited access to all series for 1 week',
      name: 'unlimited_access_weekly',
      desc: '',
      args: [],
    );
  }

  /// `Double EXP`
  String get double_exp {
    return Intl.message('Double EXP', name: 'double_exp', desc: '', args: []);
  }

  /// `Experience gained within the effective time*2`
  String get double_exp_desc {
    return Intl.message(
      'Experience gained within the effective time*2',
      name: 'double_exp_desc',
      desc: '',
      args: [],
    );
  }

  /// `Double Energy`
  String get double_energy {
    return Intl.message(
      'Double Energy',
      name: 'double_energy',
      desc: '',
      args: [],
    );
  }

  /// `Stamina gained within the effective time*2`
  String get double_energy_desc {
    return Intl.message(
      'Stamina gained within the effective time*2',
      name: 'double_energy_desc',
      desc: '',
      args: [],
    );
  }

  /// `VIP`
  String get clip_vip {
    return Intl.message('VIP', name: 'clip_vip', desc: '', args: []);
  }

  /// `Click to continue playing`
  String get click_to_continue {
    return Intl.message(
      'Click to continue playing',
      name: 'click_to_continue',
      desc: '',
      args: [],
    );
  }

  /// `Unlock Now`
  String get unlock_now {
    return Intl.message('Unlock Now', name: 'unlock_now', desc: '', args: []);
  }

  /// `Unlock`
  String get unlock {
    return Intl.message('Unlock', name: 'unlock', desc: '', args: []);
  }

  /// `Watch AD to unlock`
  String get watch_ad_unlock {
    return Intl.message(
      'Watch AD to unlock',
      name: 'watch_ad_unlock',
      desc: '',
      args: [],
    );
  }

  /// `The stories in between are also interesting . Don’t miss out!`
  String get do_not_miss_out {
    return Intl.message(
      'The stories in between are also interesting . Don’t miss out!',
      name: 'do_not_miss_out',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get clip_detail {
    return Intl.message('Details', name: 'clip_detail', desc: '', args: []);
  }

  /// `You can unlock now`
  String get can_unlock_now {
    return Intl.message(
      'You can unlock now',
      name: 'can_unlock_now',
      desc: '',
      args: [],
    );
  }

  /// `Watch Now`
  String get watch_now {
    return Intl.message('Watch Now', name: 'watch_now', desc: '', args: []);
  }

  /// `Guess You Like`
  String get guess_you_like {
    return Intl.message(
      'Guess You Like',
      name: 'guess_you_like',
      desc: '',
      args: [],
    );
  }

  /// `· Auto renew · Cancel anytime`
  String get auto_renew_cancel_anytime {
    return Intl.message(
      '· Auto renew · Cancel anytime',
      name: 'auto_renew_cancel_anytime',
      desc: '',
      args: [],
    );
  }

  /// `· No ADs`
  String get no_ads {
    return Intl.message('· No ADs', name: 'no_ads', desc: '', args: []);
  }

  /// `· Unlimited access to all series`
  String get unlimited_access_premium {
    return Intl.message(
      '· Unlimited access to all series',
      name: 'unlimited_access_premium',
      desc: '',
      args: [],
    );
  }

  /// `Popular`
  String get clip_popular {
    return Intl.message('Popular', name: 'clip_popular', desc: '', args: []);
  }

  /// `Discount For a Weekly Member's First Week`
  String get weekly_vip_title {
    return Intl.message(
      'Discount For a Weekly Member\'s First Week',
      name: 'weekly_vip_title',
      desc: '',
      args: [],
    );
  }

  /// `Limited Time`
  String get limited_time {
    return Intl.message(
      'Limited Time',
      name: 'limited_time',
      desc: '',
      args: [],
    );
  }

  /// `Ad not ready`
  String get ad_not_ready {
    return Intl.message(
      'Ad not ready',
      name: 'ad_not_ready',
      desc: '',
      args: [],
    );
  }

  /// `See Offer`
  String get see_offer {
    return Intl.message('See Offer', name: 'see_offer', desc: '', args: []);
  }

  /// `My List`
  String get my_list {
    return Intl.message('My List', name: 'my_list', desc: '', args: []);
  }

  /// `My Wallet`
  String get my_wallet {
    return Intl.message('My Wallet', name: 'my_wallet', desc: '', args: []);
  }

  /// `Invite`
  String get clip_invite {
    return Intl.message('Invite', name: 'clip_invite', desc: '', args: []);
  }

  /// `Coupons`
  String get clip_coupons {
    return Intl.message('Coupons', name: 'clip_coupons', desc: '', args: []);
  }

  /// `Use Vigor to unlock episodes`
  String get use_vigor_unlock_ep {
    return Intl.message(
      'Use Vigor to unlock episodes',
      name: 'use_vigor_unlock_ep',
      desc: '',
      args: [],
    );
  }

  /// `Unlock episodes`
  String get unlock_episodes {
    return Intl.message(
      'Unlock episodes',
      name: 'unlock_episodes',
      desc: '',
      args: [],
    );
  }

  /// `loading…`
  String get loading {
    return Intl.message('loading…', name: 'loading', desc: '', args: []);
  }

  /// `Network Connected`
  String get network_connected {
    return Intl.message(
      'Network Connected',
      name: 'network_connected',
      desc: '',
      args: [],
    );
  }

  /// `Losing Network Connection`
  String get network_losing {
    return Intl.message(
      'Losing Network Connection',
      name: 'network_losing',
      desc: '',
      args: [],
    );
  }

  /// `Network Connection Lost`
  String get network_lost {
    return Intl.message(
      'Network Connection Lost',
      name: 'network_lost',
      desc: '',
      args: [],
    );
  }

  /// `Network Not Available`
  String get network_not_available {
    return Intl.message(
      'Network Not Available',
      name: 'network_not_available',
      desc: '',
      args: [],
    );
  }

  /// `The network connection timed out. Please try again later`
  String get network_connection_timed_out_try_later {
    return Intl.message(
      'The network connection timed out. Please try again later',
      name: 'network_connection_timed_out_try_later',
      desc: '',
      args: [],
    );
  }

  /// `connect failed`
  String get connect_failed {
    return Intl.message(
      'connect failed',
      name: 'connect_failed',
      desc: '',
      args: [],
    );
  }

  /// `Ah, I can't connect to the network`
  String get cannot_connect_network {
    return Intl.message(
      'Ah, I can\'t connect to the network',
      name: 'cannot_connect_network',
      desc: '',
      args: [],
    );
  }

  /// `parse error`
  String get parse_error {
    return Intl.message('parse error', name: 'parse_error', desc: '', args: []);
  }

  /// `conversion error`
  String get conversion_error {
    return Intl.message(
      'conversion error',
      name: 'conversion_error',
      desc: '',
      args: [],
    );
  }

  /// `Certificate verification failed`
  String get certificate_verification_failed {
    return Intl.message(
      'Certificate verification failed',
      name: 'certificate_verification_failed',
      desc: '',
      args: [],
    );
  }

  /// `Unknown Error`
  String get unknown_error {
    return Intl.message(
      'Unknown Error',
      name: 'unknown_error',
      desc: '',
      args: [],
    );
  }

  /// `Automatically use Vigor unlock episodes`
  String get automatically_use_vigor_unlock_episodes {
    return Intl.message(
      'Automatically use Vigor unlock episodes',
      name: 'automatically_use_vigor_unlock_episodes',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'pt'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
