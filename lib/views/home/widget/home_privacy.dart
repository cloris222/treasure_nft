import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_text_style.dart';
import 'package:treasure_nft_project/views/home/widget/home_usdt_info.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';

import '../../../constant/theme/app_image_path.dart';
import '../../../constant/ui_define.dart';
import '../../../view_models/base_view_model.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../../widgets/label/background_with_land.dart';
import '../../custom_appbar_view.dart';
import '../home_main_style.dart';


class HomePrivacy extends StatelessWidget with HomeMainStyle {
  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
      needBottom: false,
      needScrollView: false,
      onLanguageChange: () {
        // if (mounted) {
        //   setState(() {});
        // }
      },
      type: AppNavigationBarType.typePersonal,
      body: Stack(
        children: [
          SizedBox(height: UIDefine.getHeight(), width: UIDefine.getWidth()),
          Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: BackgroundWithLand(
                backgroundColor: Colors.white,
                mainHeight: 230,
                bottomHeight: 180,
                onBackPress: () => BaseViewModel().popPage(context),
                body: const SizedBox(),
              )),
          Positioned(
            top: 50 + UIDefine.getPixelWidth(10),
            bottom: 0,
            right: UIDefine.getPixelWidth(20),
            left: UIDefine.getPixelWidth(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(top: UIDefine.getPixelWidth(24),bottom: UIDefine.getPixelWidth(8)),
                      child: Text("Privacy Policy",
                      style: AppTextStyle.homeTitleStyle(),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: UIDefine.getPixelWidth(16),),
                      child: Text("2022/09/06",
                      style: AppTextStyle.baseStyle(fontSize: 10,color: Color(0xFF818181),),),
                    ),
                  ),
                  Container(
                    height: UIDefine.getPixelWidth(2),
                    width: UIDefine.getWidth(),
                    color: Color(0xFF111111).withOpacity(0.05),
                  ),
                  SizedBox(height: UIDefine.getPixelWidth(16),),
                  Text("Your privacy is very important to us. The TreasureMeta Technology Company (together with its subsidiaries and other affiliated entities, “Treasure”), is committed to maintaining your privacy.\n\n"
                    "This privacy policy is intended to inform you of:\n"
                    "● The types of information we collect\n"
                    "● How we use information we collect\n"
                    "● How we share information we collect\n"
                    "● How we safeguard information we collect\n"
                    "● Other important privacy information\n\n"
                    "This policy applies to you whenever you access or use any domains or subdomains of our website at treasurenft.xyz (the “Website”), or when you access or use or any products, services, features, content, widgets, materials or other tools offered by Treasure (collectively, “Services”). This policy does not govern information you choose to exchange directly with other users of the Website, including communications or transactions with other users via the Discord channel, as we have no direct control over the collection or use of this information. Please note that your relationship with Treasure is governed by our Terms of Use and any other agreements you may enter in connection with accessing our services.\n\n"
                    ,style: AppTextStyle.baseStyle(),),
                  Text("1. Types of Information We Collect",style: AppTextStyle.homeTitleStyle(),),
                  Text("To provide our Services, we may obtain personal information directly from you (including but not limited to email addresses and phone numbers) and may obtain information indirectly through electronic communications and third parties (e.g., email, Discord, Twitter).\n\n"
                    "We do not save or store any sensitive wallet information or private keys though we may index transactions recorded on public blockchains."
                    "We do not administer or control any public blockchains.\n",style: AppTextStyle.baseStyle(),),
                  Text("Automatically or Passively Collected Information:",style: AppTextStyle.baseStyle(fontWeight: FontWeight.bold),),
                  Text("In addition to the information you may directly provide us, we may automatically or passively collect information when you access or use the Services, including your IP address, device identifiers, click path, use of our Website and other electronic data. We may also record page views (hit counts) and other general statistical and tracking information, which will be aggregated with that of other users in order to understand how our Website and Services are being used, and for security and monitoring purposes. In order to determine whether your computer is supported by our system, we may collect additional technical information, including your operating system and browser, as well as the presence of any software that our Services or Website may require to operate with your computer, or other thirdparty software on your computer.\n\n"
                    "A “cookie” is a small amount of data, often including an anonymous unique identifier, which is sent to your browser from a website's computers and stored on your computer's hard drive. Cookies can be used to provide you with a tailored user experience and to make it easier for you to use a website upon a future visit. We may include cookies on our website or within the Services and use them to recognize you when you return to our website or utilize the Services. You may set your browser so that it does not accept cookies. Cookies must be enabled on your web browser, however, if you wish to access certain personalized features of our Services. By using the Website, you consent to this use.\n\n"
                    "We may also use so-called “pixel tags“ – small graphic images (also known as “web beacons“ or “single-pixel GIFS“) – to tell us what parts of our website have been visited or how the Services have been utilized.\n\n"
                    "We may send email messages that use a “click-through URL” linked to content on our website. When you click one of these URLs, you pass through our web server before arriving at the destination web page. We track this click-through data to help determine interest in particular topics and measure the effectiveness of our communications. If you prefer not to be tracked, simply do not click text or graphic links in the email, or notify us at official@treasurenft.xyz.\n",
                  style: AppTextStyle.baseStyle(),),
                  Text("Information Related to Your use of the Services:",style: AppTextStyle.baseStyle(fontWeight: FontWeight.bold),),
                  Text("We collect certain information about you when you visit the Website and interact with any of our Services. We collect information about when you use the Services, the pages within the Website you visit, the links you click on, and the search terms you use.\n\n"
                    ,style: AppTextStyle.baseStyle(),),
                  // 2. Title
                  Text("2. How We Use Information We Collect",style: AppTextStyle.homeTitleStyle(),),
                  Text("We may use your information for any of the following purposes:\n"
                    "● Administer, operate, facilitate, and manage your relationship with Treasure and deliver the Services.\n"
                    "● To communicate with you about the Services and target our marketing, advertising and other efforts to enhance your user experience and increase engagement.\n"
                    "● Provide you with information about our current Services\n"
                    "● To debug, identify and correct errors;\n"
                    "● On a de-identified, aggregated basis, for research and development activities, including to analyze how you use the Services to help us understand usage patterns and know if there are problems with the Services or areas for improvement;\n"
                    "● Send you notifications related to Treasure, vaults or other Services\n"
                    "● Respond to inquiries related to employment opportunities or other similar inquiries\n"
                    "● Comply with applicable laws and regulations and cooperate with investigations by law enforcement or other authorities\n"
                    "● Act in accordance with any reason for which you have provided data to Treasure related to the Services\n"
                    "In addition, if we are involved in a merger, acquisition, financing due diligence, reorganization, bankruptcy, creation of a trust or other affiliated entity, receivership or sale of Treasure’s assets, or other corporate transaction affecting Treasure, your information may be shared, transferred or sold under a duty of confidentiality as part of a transaction as permitted by law or by contract. If your relationship with Treasure ends, we will continue to treat your personal information, to the extent we retain it, as described in this policy.",
                    style: AppTextStyle.baseStyle(),),
                  // 3. Title
                  Text("3. How We Share Information We Collect",style: AppTextStyle.homeTitleStyle(),),
                  Text("We do not share personal data with third parties for their direct marketing or similar purposes without your consent. We also do not offer financial incentives, preferential service agreements, or any other differences in our prices or Services in exchange for your data.\n\n"
                    "The manner in which partners, service providers and others with whom we share and/or disclose your information is governed by the policies of such parties, and we shall have no liability or responsibility for the privacy practices or other actions of any such parties.\n\n"
                    "Generally, you can easily recognize when one of our partners is associated with a service. However, certain parties may provide services anonymously, and, in this case, we will only share information that is directly related to the applicable service(s). This may include the incorporation of your personal information into databases maintained to validate information for identity verification, including verification for anti-money laundering and “Know Your Customer” protocols.\n\n"
                    "The primary situations in which we may share your data are as follows:",style: AppTextStyle.baseStyle(),),
                  Text("Potential Business Combination:",style: AppTextStyle.baseStyle(fontWeight: FontWeight.bold),),
                  Text("We may transfer your personal information to a third party as a result of a business combination, merger, asset sale, reorganization or similar transaction or to governmental authorities when we reasonably believe it is required by law or appropriate to respond to legal process. We will also share your information with third-party companies, organizations or individuals if we have a good faith belief that access, use, preservation or disclosure of your information is reasonably necessary to detect or protect against fraud or security issues, enforce our terms of use, meet any enforceable government request, defend against legal claims or protect against harm of our legal rights or safety. In any such event, and to the extent legally permitted, we will notify you and, if there are material changes in relation to the processing of your Personal Information, give you an opportunity to consent to such changes. Any third party with whom we share your data with will be required to provide the same or equal protection of such data as stated in our policy.\n",
                    style: AppTextStyle.baseStyle()),
                  Text("Service Providers:",style: AppTextStyle.baseStyle(fontWeight: FontWeight.bold),),
                  Text("To operate the Services we may share information about you as needed with our service providers, including, but not limited to, accountants, auditors, lawyers, consultants, advisors and affiliates.\n",
                    style: AppTextStyle.baseStyle(),),
                  Text("Affiliates:",style: AppTextStyle.baseStyle(fontWeight: FontWeight.bold),),
                  Text(" We may share information with companies closely related to us, if any, – our “Affiliates” – for certain purposes under this policy. By ”Affiliate,“ we mean an entity that controls, is controlled by, or is under common control with Treasure, whether the control results from equity ownership, contract, overlapping management or otherwise. In this context, “control” means the ability to replace the officers or directors or otherwise materially influence or control management decisions. Our Affiliates will be entitled to enjoy our rights under this policy and we will be responsible for our Affiliate's conduct under this policy.\n",
                  style: AppTextStyle.baseStyle(),),
                  Text("Third-Party Sites:",style: AppTextStyle.baseStyle(fontWeight: FontWeight.bold),),
                  Text("The Website may contain links to third party websites and may redirect you to third party websites. These sites include, among others, service providers who may or may not have a relationship with Treasure. Third party websites are not under our control, and we are not responsible for any third party websites, or the accuracy, sufficiency, correctness, reliability, veracity, completeness, or timeliness of their information, links, changes or updates. The inclusion or access to these websites does not imply an endorsement by Treasure, or of the provider of such content or services, or of any third party website. Please be aware that when you enter a third party website, any information you provide, including financial information, is subject to the terms of use and privacy policy of that website.\n\n",
                  style: AppTextStyle.baseStyle(),),
                  // 4. Title
                  Text("4. How We Safeguard Your Personal Information",style: AppTextStyle.homeTitleStyle(),),
                  Text("Security Systems and Processes: We have put in place security systems designed to prevent unauthorized access to or disclosure of Personally Identifiable Information, and we take all reasonable steps to secure and safeguard this information, including:\n"
                  "● We use industry standard encryption technology for any information we store;\n"
                  "● Treasure employees are required to acknowledge that they understand and will abide by this policy with respect to the confidentiality of Personal Information;\n"
                  "● Where applicable, companies that we do business with agree to apply similar safeguards to Personal Information;\n"
                  "● We provide access to our databases containing Personal Information on a need-toknow basis only;\n"
                  "● We use automated tools to monitor network traffic to identify unauthorized attempts to upload information, change information, or otherwise seek to “hack into” our systems.\n\n"
                  "Our security systems are therefore structured to deter and prevent hackers and others from accessing information you provide to us. Please understand, though, that this information should not be construed as a warranty that our security systems are fail proof. Due to the nature of Internet communications and evolving technologies, we cannot provide and we also disclaim assurance that the information you provide us will remain free from loss, misuse, or alteration by third parties who, despite our efforts, obtain unauthorized access.\n\n",
                  style: AppTextStyle.baseStyle(),),
                  // 5. Title
                  Text("5. Other Important Privacy Information",style: AppTextStyle.homeTitleStyle(),),
                  Text("Opting Out of Communications: ",style: AppTextStyle.baseStyle(fontWeight: FontWeight.bold),),
                  Text("If you wish to stop receiving marketing or promotional communications or to opt out of use of your information for the purposes described in this policy, please follow the opt-out instructions, such as clicking “Unsubscribe” (or similar opt-out language), in those communications. You can also contact us at official@treasurenft.xyz to opt out. Despite your indicated email preferences, we may send you service-related communications, including notices of any updates to our terms of service or this policy. Please understand that you will not be allowed to opt–out of certain communications required to comply with applicable laws, rules and regulations or other legal and related notices concerning your relationship to the Website.\n",
                    style: AppTextStyle.baseStyle(),),
                  Text("Changing or Deleting Information: ",style: AppTextStyle.baseStyle(fontWeight: FontWeight.bold),),
                  Text("All users may review, update, correct or delete the Personal Information furnished by a user by contacting us at official@treasurenft.xyz. If you request, we will take reasonable steps to remove your personal information from our databases. Please understand, however, that certain Personal Information may remain in our databases following the deletion of your account pursuant to our data retention policy.\n",
                    style: AppTextStyle.baseStyle(),),
                  Text("Data Retention: ",style: AppTextStyle.baseStyle(fontWeight: FontWeight.bold),),
                  Text("We retain information we collect for as long as you use the Services or as necessary to fulfill the purposes for which it was collected, such as providing our Services, resolving any disputes, establishing legal defenses, enforcing our agreements and complying with applicable laws. We may retain information that is otherwise deleted in anonymized and aggregated form, in archived or backup copies as required pursuant to records retention obligations or otherwise as required by law. We may retain an archived copy of your records as required by law or for legitimate business purposes.\n"
                    ,style: AppTextStyle.baseStyle(),),
                  Text("Download or Access Personal Information: ",style: AppTextStyle.baseStyle(fontWeight: FontWeight.bold),),
                  Text("You can ask us for a copy of your Personal Information, including a copy in machine readable form, by emailing us at official@treasurenft.xyz.\n",style: AppTextStyle.baseStyle(),),
                  Text("Changes to this Policy: ",style: AppTextStyle.baseStyle(fontWeight: FontWeight.bold),),
                  Text("Each time you visit our Website or use our Services, the current version of this privacy policy will apply. When you use our Website or the Services, you should check the date of the last update to the policy (which appears at the top of the policy) and review any changes since the last version. Our business changes frequently and this policy is subject to change from time to time. Unless stated otherwise, our current policy applies to all information that we have about you. We may require you to affirmatively assent to a revised version of this policy as a condition of continuing to use the Website or our Services.\n",style: AppTextStyle.baseStyle(),),
                  Text("We Operate in the United Kingdom: ",style: AppTextStyle.baseStyle(fontWeight: FontWeight.bold),),
                  Text("Treasure is based in the United Kingdom. The Services are controlled and operated by us from the United Kingdom and are not intended to subject us to the laws or jurisdiction of any country or territory other than that of the United Kingdom. Your personal information may be stored and processed in any country where we have facilities or in which we engage service providers, and by using the Services, you consent to the transfer of information to countries outside of your country of residence, including the United Kingdom, which may have data protection rules that are different from those of your country. In certain circumstances, courts, law enforcement agencies, regulatory agencies or security authorities in those other countries may be entitled to access your personal information.\n",style: AppTextStyle.baseStyle(),),
                  Text("European Economic Area Residents: ",style: AppTextStyle.baseStyle(fontWeight: FontWeight.bold),),
                  Text("If you are an individual residing in the European Economic Area (“EEA”) or United Kingdom, we collect and process information about you only where we have legal bases for doing so under applicable laws, including the General Data Protection Regulation (“GDPR”). The legal bases depend on the Services you use and how you use them. This means we collect and use your information only where:\n"
                    "● We need it to provide you the Services, including to operate the Services, perform a contract with you, take necessary steps prior to performing a contract or at your request, provide customer support, and to protect the safety and security of the Services;\n"
                    "● It satisfies a legitimate interest (which is not overridden by your data protection interests), such as for research and development, to market and promote the Services, to personalize services you receive, and to protect our legal rights and interests\n"
                    "You give us consent to do so for a specific purpose; or we need to process your data to comply with a legal requirement. If you have consented to our use of information about you for a specific purpose, you may change your mind at any time, but this will not affect any processing that has already taken place. Where we are using your information because we have a legitimate interest to do so, you may object to that use though, in some cases, this may mean no longer using the Services. To do so, please email us at official@treasurenft.xyz.\n"
                    "In the event of a data breach, we will endeavor to notify you within 72 hours of detection of a breach that we conclude poses significant risks to your rights and freedoms under the GDPR. You may also lodge a complaint with a supervisor authority in the jurisdiction in which you reside.",style: AppTextStyle.baseStyle(),),
                  Text("Residents of Other Jurisdictions: ",style: AppTextStyle.baseStyle(fontWeight: FontWeight.bold),),
                  Text("If you wish to exercise rights granted to you by laws of any jurisdiction other than the EU, please contact us for assistance at official@treasurenft.xyz. We will endeavor to act upon your request in accordance with applicable law. We will not discriminate against you for exercising these rights.\n\n",style: AppTextStyle.baseStyle(),),
                  Text("Contact Us: ",style: AppTextStyle.baseStyle(fontWeight: FontWeight.bold),),
                  Text("If you have any questions about this policy, the practices of this Website, or your dealings with any of the Services, please contact us by email as follows: official@treasurenft.xyz.\n",
                  style: AppTextStyle.baseStyle(),)
                ],
              ),
            ),
          ),
        ],
      ),

    );
  }

  const HomePrivacy({Key? key}) : super(key: key);
}
