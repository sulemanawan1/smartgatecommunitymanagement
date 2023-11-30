import 'package:get/get.dart';
import 'package:userapp/Module/Discussion%20Form/View/discussion_form.dart';
import 'package:userapp/Module/Emergency%20Contacts/View/emergency_contact.dart';
import 'package:userapp/Module/Events/View/events_screen.dart';
import 'package:userapp/Module/Family%20Member/Add%20Family%20Member/View/add_family_member.dart';
import 'package:userapp/Module/Family%20Member/View%20Family%20Member/View/view_family_member.dart';
import 'package:userapp/Module/Market%20Place/View/market_place_product_details.dart';
import 'package:userapp/Module/Monthly%20Bills/View/monthly_bills.dart';
import 'package:userapp/Module/Profile/View/profile.dart';
import 'package:userapp/Module/Splash/View/splash_screen.dart';
import 'package:userapp/Module/Verification/Change%20Password/View/forget_password.dart';
import 'package:userapp/Module/Verification/Verification%20Code/View/verification_code.dart';
import 'package:userapp/Routes/screen_binding.dart';
import 'package:userapp/Routes/set_routes.dart';
import 'package:userapp/Widgets/image_show.dart';

import '../Module/Add PreApprove Entry/View/add_pre_aprove_entry.dart';
import '../Module/Chat Availbility/View/chat_availbility_screen.dart';
import '../Module/Chat Screens/Neighbour Chat Screen/View/neighbour_chat_screen.dart';
import '../Module/Emergency/View/emergency_screen.dart';
import '../Module/Guest History/View/guests_history_screen.dart';
import '../Module/HomeScreen/View/home_screen.dart';
import '../Module/Login/View/login_screen.dart';
import '../Module/Market Place/View/market_place_screen.dart';
import '../Module/NoticeBoard/View/notice_board_screen.dart';
import '../Module/Pre Approve Entry/View/pre_approve_entry_screen.dart';
import '../Module/Report to Sub Admin/View/Admin Reports/admin_reports.dart';
import '../Module/Report to Sub Admin/View/Report to Admin/report_to_admin.dart';
import '../Module/ReportsHistory/View/admin_reports_history_screen.dart';
import '../Module/Sell Products/View/sell_products_screen.dart';
import '../Module/Signup/Resident Address Detail/View/resident_address_detail.dart';
import '../Module/Signup/Resident Personal Detail/View/resident_personal_detail.dart';
import '../Module/Verification/Register/View/register.dart';

class RouteManagement {
  static List<GetPage> getPages() {
    return [
      GetPage(
          name: splashscreen,
          page: () => SplashScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: loginscreen,
          page: () => Login(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: homescreen,
          page: () => HomeScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: eventsscreen,
          page: () => EventsScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: neighbourchatscreen,
          page: () => NeighbourChatScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: chatavailbilityscreen,
          page: () => ChatAvailbilityScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: reporttoadmin,
          page: () => ReportToAdmin(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: adminreports,
          page: () => AdminReports(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: preapproveentryscreen,
          page: () => PreApproveEntryScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: addpreapproveentryscreen,
          page: () => AddPreApproveEntry(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: reportshistoryscreen,
          page: () => ReportsHistoryScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: guestshistoryscreen,
          page: () => GuestsHistoryScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: viewimage,
          page: () => ViewImage(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: noticeboardscreen,
          page: () => NoticeBoardScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: gatekeeperreports,
          page: () => PreApproveEntryScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: residentpersonaldetail,
          page: () => ResidentPersonalDetail(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: residentaddressdetail,
          page: () => ResidentAddressDetail(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: addfamilymember,
          page: () => AddFamilyMember(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: viewfamilymember,
          page: () => ViewFamilyMember(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: discussion_form,
          page: () => DiscussionForm(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: monthly_bill,
          page: () => MonthlyBills(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: marketPlaceScreen,
          page: () => MarketPlaceScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: sellProductsScreen,
          page: () => SellProductsScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: addEmergencyScreen,
          page: () => AddEmergencyScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: verificationCode,
          page: () => VerificationCode(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: foregetPassword,
          page: () => ForgetPassword(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: marketPlaceProductDetails,
          page: () => MarketPlaceProductDetails(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: register,
          page: () => Register(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: profile,
          page: () => Profile(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: emergencyContact,
          page: () => EmergencyContact(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
    ];
  }
}
