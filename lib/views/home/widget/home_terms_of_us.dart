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


class HomeTermsOfUs extends StatelessWidget with HomeMainStyle {
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
                      child: Text("Terms of Use",
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
                  Text("Welcome to Treasure NFT. The Treasure NFT service and network (collectively, the “Service“) are operated by The TreasureMeta Technology Token Company, and its affiliates (collectively, the “Company“, “we“, or “us“). By accessing or using our website at treasurenft.xyz, including any subdomain thereof (the “Site“), you (the “User“) signify that you have read, understand and agree to be bound by these terms of use (“Terms of Use“), regardless of whether you are a registered member of the Service. In addition to these Terms of Use, you may enter into other agreements with us or others that will govern your use of the Service or related services offered by us or others. If there is any contradiction between these Terms of Use and another agreement you enter into applicable to specific aspects of the Service, the other agreement shall take precedence in relation to the specific aspects of the Service to which it applies. As used herein, “Users“ means anyone who accesses and or uses the Site. For any terms herein applicable to all Users, or business and other entity Users specifically, or where the context otherwise requires, “Users“ shall be deemed to include any business or other entity on behalf of which the Site or Service is accessed by any other User, and “you“ shall be deemed to include any such business or other entity and any person acting on behalf of any such business or other entity in connection with the use of the Site or Service.\n\n"
                    ,style: AppTextStyle.baseStyle(),),
                  Text("Changes to these Terms of Use",style: AppTextStyle.homeTitleStyle(),),
                  Text("We may make changes to these Terms of Use from time to time. If we do this, we will post the changed Terms of Use on the Site and will indicate at the top of this page the date the Terms of Use were last revised. You understand and agree that your continued use of the Service or the Site after we have made any such changes constitutes your acceptance of the new Terms of Use.\n\n",style: AppTextStyle.baseStyle(),),
                  Text("TERMS APPLICABLE TO ALL USERS: ELIGIBILITY, LICENSE AND REPRESENTATIONS\n\n",style: AppTextStyle.homeTitleStyle(),),
                  Text("Eligibility: General",style: AppTextStyle.homeTitleStyle(),),
                  Text("By using the Service or the Site, you agree to and will abide by all of the terms and conditions of these Terms of Use. If you violate any of these Terms of Use, or otherwise violate an agreement between you and us, the Company may revoke your access and any content or information that you have posted on the Site and/or prohibit you from using or accessing the Service or the Site (or any portion, aspect or feature of the Service or the Site), at any time in its sole discretion, with or without notice.\n"
                      "Restrictions on Data Collection/Termination"
                      "Without our prior consent, you may not:/n"
                      "● Use any automated means to access this Site or collect any information from the Site (including, without limitation, robots, spiders, scripts or other automatic devices or programs);\n"
                      "● Frame the Site, utilize framing techniques to enclose any Content or other proprietary information, place popup windows over this Site's pages, or otherwise affect the display of this Site's pages; engage in the practices of “screen scraping”, ”database scraping” or any other activity with the purpose of obtaining content or other information; or\n"
                      "● Use this Site in any manner that violates applicable law or that could damage, disable, overburden, or impair this Site or interfere with any other party's use and enjoyment of this Site.\n"
                      "We may terminate, disable or throttle your access to, or use of, this Site and the Services for any reason, including without limitation, if we believe that you have violated or acted inconsistently with any portion of these Terms of Use.",
                      style: AppTextStyle.baseStyle(),),
                  Text("User Representations",style: AppTextStyle.homeTitleStyle(),),
                  Text("You represent, warrant and agree that no materials of any kind submitted through your account or otherwise posted or shared by you through the Service will violate or infringe upon the rights of any third party, including copyright, trademark, privacy, publicity or other personal or proprietary rights; or contain libelous, defamatory or otherwise unlawful material. Additionally, you agree not to use automated scripts to collect information from the Service or the Site or for any other purpose. You further agree that you may not use the Service or the Site in any unlawful manner or in any other manner that could damage, disable, overburden or impair the Site. In addition, you agree not to use the Service or the Site to:\n"
                    "● Upload, post, transmit, share, store or otherwise make available any content that we deem to be harmful, threatening, unlawful, defamatory, infringing, abusive, inflammatory, harassing, vulgar, obscene, fraudulent, invasive of privacy or publicity rights, hateful, or racially, ethnically or otherwise objectionable;\n"
                    "● Upload, post, transmit, share or otherwise make available any unsolicited or unauthorized advertising, solicitations, promotional materials, “junk mail“, “spam“, “chain letters“, “pyramid schemes“, or any other form of solicitation;\n"
                    "● Upload, post, transmit, share, store or otherwise make publicly available on the Site any private information of any third party, including, without limitation, addresses, phone numbers, email addresses, Social Security numbers and credit card numbers;\n"
                    "● Upload, post, transmit, share or otherwise make available any material that contains software viruses or any other computer code, files or programs designed to interrupt, destroy or limit the functionality of any computer software or hardware or telecommunications equipment; intimidate or harass another User;\n"
                    "● Upload, post, transmit, share, store or otherwise make available content that would constitute, encourage or provide instructions for a criminal offense, violate the rights of any party, or that would otherwise create liability or violate any local, state, national or international law;\n"
                    "● Use or attempt to use another's account, service or system without authorization from that person and the Company, or create a false identity on the Service or the Site; or\n"
                    "● Use any funds derived or obtained from an illegal activity or source to make a purchase through the Treasure NFT Platform; or\n"
                    "● Upload, post, transmit, share, store or otherwise make available content that, in the sole judgment of the Company, is objectionable or which restricts or inhibits any other person from using or enjoying the Site, or which may expose the Company or its Users to any harm or liability of any type.\n\n"
                    ,style: AppTextStyle.baseStyle(),),
                  Text("ALL USERS: CONSENT TO ELECTRONIC TRANSACTIONS AND DISCLOSURES",style: AppTextStyle.homeTitleStyle(),),
                  Text("Because Treasure NFT operates on the Internet, it is necessary for you to consent to transact business with us online and electronically. As part of doing business with us, therefore, we also need you to consent to our giving you certain disclosures electronically, either via our Site or to the email address (or other electronic means of communication) you provide to us. The decision to do business through us electronically is yours. This document informs you of your rights concerning Disclosures.\n",
                    style: AppTextStyle.baseStyle(),),
                  Text("Electronic Communications. ",style: AppTextStyle.baseStyle(fontWeight: FontWeight.bold),),
                  Text("Any Disclosures will be provided to you electronically through Treasure NFT either on our Site or Discord server.\n",style: AppTextStyle.baseStyle(),),
                  Text("Scope of Consent. ",style: AppTextStyle.baseStyle(fontWeight: FontWeight.bold),),
                  Text("Your consent to receive Disclosures and transact business electronically, and our agreement to do so, applies to any transactions to which such Disclosures relate, whether between you and Treasure NFT or between you and another party with whom you transact through the Site. Your consent will remain in effect for so long as you are a User and, if you are no longer a User, will continue until such a time as all Disclosures relevant to transactions that occurred while you were a User have been made. Consenting to do Business Electronically. Before you decide to do business electronically with Treasure NFT, you should consider whether you have the required hardware and software capabilities described below.\n",style: AppTextStyle.baseStyle(),),
                  Text("Hardware and Software Requirements. ",style: AppTextStyle.baseStyle(fontWeight: FontWeight.bold),),
                  Text("In order to access and retain information electronically, you must satisfy the following computer hardware and software requirements: access to the Internet; an email account and related software capable of receiving email through the Internet; supported Web browsing software (Chrome version 32.0 or higher, Firefox version 26.0 or higher, Internet Explorer version 8.0 or higher, or Safari version 7.0 or higher); and hardware capable of running this software.\n",style: AppTextStyle.baseStyle(),),
                  Text("Telephone Consumer Protection Act Overview Consent: ",style: AppTextStyle.baseStyle(fontWeight: FontWeight.bold),),
                  Text("You expressly consent to receiving calls and messages, including auto-dialed and pre-recorded message calls, and SMS messages (including text messages) from us, our affiliates, agents and others calling at their request or on their behalf, at any telephone numbers that you have provided or may provide in the future (including any cellular telephone numbers). Your cellular or mobile telephone provider will charge you according to the type of plan you carry.\n\n",style: AppTextStyle.baseStyle()),

                  Text("NO INVESTMENT ADVICE",style: AppTextStyle.homeTitleStyle(),),
                  Text("You acknowledge that Treasure NFT, does not provide investment advice or a recommendation of securities or investments. Furthermore, you agree that the contents of the Treasure NFT platform do not constitute financial, accounting, legal or tax advice from Treasure NFT. You should always obtain independent financial and tax advice from your professional advisers before making any financial decisions.\n\n",style: AppTextStyle.baseStyle(),),
                  Text("TERMS APPLICABLE TO BUSINESS AND OTHER ENTITY USERS\n\n",style: AppTextStyle.homeTitleStyle(),),
                  Text("Eligibility: Business and Other Entity Users",style: AppTextStyle.homeTitleStyle(),),
                  Text("Access to the Site for Users that are businesses, other entities or persons acting on behalf of such businesses or entities, is intended solely for authorized representatives of businesses or other entities that are in good standing in each jurisdiction in which they are registered to conduct business and persons otherwise authorized by such businesses or entities to act in furtherance of the business or entity's use of the Site or Service. By using the Service or the Site on behalf of a business or other entity, you represent and warrant that you are duly authorized in accordance with the foregoing by the business or other entity on behalf of which you are acting, that you have the power and authority to enter into binding agreements on behalf of the business or entity or in the capacity in which you are acting, and that the business or entity is in good standing in each jurisdiction in which it is registered to conduct business to the best of your knowledge. Furthermore, you confirm that you agree to all of the terms and conditions of these Terms of Use individually and on behalf of such business or other entity, and represent and warrant that you and such business or other entity will abide by all of the terms and conditions of these Terms of Use.\n\n"
                    ,style: AppTextStyle.baseStyle(),),
                  Text("Additional Representations: Business and Other Entity Users",style: AppTextStyle.homeTitleStyle(),),
                  Text("In addition to the User Representations set forth above under \"User Representations\", which you hereby confirm on behalf of the business or entity member, you further agree, both individually and on behalf of the business or entity, not to use the Service or the Site to:\n"
                      "● Communicate with any other User regarding the business or entity, or its business operations, other than anonymously and publicly via the Site, or upload, post, transmit, share or otherwise make available any information or informational material identifying the business or entity or its business operations (other than Business Data provided to the Company or other information requested by the Company or otherwise necessary for your use of the Site or Service); and\n"
                      "● Upload, post, transmit, share, store or otherwise make publicly available on the Site any private information regarding the business or entity, including, without limitation, addresses, phone numbers, email addresses, tax identification numbers and credit, or any personal information regarding persons associated with the business or entity (other than Business Registration Data provided to the Company).\n"
                      "Furthermore, you represent and warrant and agree, both individually and on behalf of the business or entity, that:\n"
                      "● All email addresses provided on behalf of the business or entity are and will be used by the business or entity for business purposes; and\n"
                      "● You will not represent or portray the business or entity as being affiliated with the Company in any capacity other than being a User of the Site or Service without the Company's prior written consent.\n\n",
                      style: AppTextStyle.baseStyle(),),
                  Text("ALL USERS: INTELLECTUAL PROPERTY MATTERS\n\n",style: AppTextStyle.homeTitleStyle(),),
                  Text("Trademarks",style: AppTextStyle.homeTitleStyle(),),
                  Text("Treasure NFT and other Company graphics, logos, designs, page headers, button icons, scripts and service names are registered trademarks, trademarks or trade dress of the Company in the U.S. and/or other countries. The Company's trademarks and trade dress may not be used, including as part of trademarks and/or as part of domain names, in connection with any product or service in any manner that is likely to cause confusion and may not be copied, imitated, or used, in whole or in part, without the prior written permission of the Company.",style: AppTextStyle.baseStyle(),),
                  Text("Copyright Complaints",style: AppTextStyle.homeTitleStyle(),),

                  Text("If you believe that any material on the Site infringes upon any copyright which you own or control, you may send a written notification of such infringement to our Designated Agent as set forth below:\n"
                    "Name of Agent Designated to Receive Notification of Claimed Infringement: Attention: Treasure NFT Team\n"
                    "Email Address of Designated Agent: official@treasurenft.xyz\n"
                    "To meet the notice requirements under the Digital Millennium Copyright Act, the notification must be a written communication that includes the following:\n"
                    "● A physical or electronic signature of a person authorized to act on behalf of the owner of an exclusive right that is allegedly infringed;\n"
                    "● Identification of the copyrighted work claimed to have been infringed, or, if multiple copyrighted works at a single online site are covered by a single notification, a representative list of such works at that site;\n"
                    "● Identification of the material that is claimed to be infringing or to be the subject of infringing activity and that is to be removed or access to which is to be disabled, and information reasonably sufficient to permit us to locate the material;\n"
                    "● Information reasonably sufficient to permit us to contact the complaining party, such as an address, telephone number and, if available, an electronic mail address at which the complaining party may be contacted;\n"
                    "● A statement that the complaining party has a good-faith belief that use of the material in the manner complained of is not authorized by the copyright owner, its agent or the law; and\n"
                    "● A statement that the information in the notification is accurate, and under penalty of perjury, that the complaining party is authorized to act on behalf of the owner of an exclusive right that is allegedly infringed.\n\n",
                      style: AppTextStyle.baseStyle(),),
                  Text("Submissions",style: AppTextStyle.homeTitleStyle(),),
                  Text("You acknowledge and agree that any questions, comments, suggestions, ideas, feedback or other information about the Site or the Service (“Submissions“), provided by you to the Company are non-confidential and shall become the sole property of the Company. The Company shall own exclusive rights, including all intellectual property rights, and shall be entitled to the unrestricted use and dissemination of these Submissions for any purpose, commercial or otherwise, without acknowledgment or compensation to you.\n\n",
                      style: AppTextStyle.baseStyle()),
                  Text("TERMS APPLICABLE TO SECONDARY MARKET USERS:",style: AppTextStyle.homeTitleStyle(),),
                  Text("Any secondary transfer activity of Treasure NFT ownership tokens that were originally minted by the Treasure NFT protocol can occur over any interface or medium that enables interaction with the decentralized Ethereum blockchain network, such as a decentralized exchange, ethereum wallet, or other smart contracts. Transactions on the Ethereum blockchain network will be affected between participants (i.e collectors and sellers). By participation on the Ethereum blockchain network, you acknowledge your understanding that: (i) all transactions will be executed using tools made available for the ethereum blockchain network, (ii) all negotiations and confirmation activities will be performed by Users, independent third-parties, or smart contracts and will not involve Treasure NFT, and (iii) Treasure NFT does not receive, transfer or hold funds or ownership tokens on any centralized database or server.\n"
                    "“Electronic Fund Transfer” means any transfer of funds, other than a transaction originated by check, draft or similar paper instrument, that is initiated through an electronic device or computer to instruct the Treasure NFT protocol to debit or credit a blockchain wallet address. Electronic Fund Transfers include such electronic transactions as direct deposits or withdrawals of funds, transfers initiated via website or mobile application./n"
                    "Your Liability: Authorized Transfers. You are liable for an Electronic Fund Transfer that you authorize, whether directly or indirectly\n\n",
                    style: AppTextStyle.baseStyle(),),
                  Text("MESSAGING",style: AppTextStyle.homeTitleStyle(),),
                  Text("Direct messaging between certain Users (“Messaging Services”) may occur through other platforms or communication channels. The Messaging Services are intended to be used for factual questions and answers between Users regarding specific transactions proposed to be executed on the Ethereum blockchain network. The Messaging Services shall not be used for other commercial or non-commercial purposes, including, without limitation, marketing, advertising, promotion of violence, personal attacks or threats, abusive behavior, harassment, profanity or hateful imagery. As a User of the Ethereum blockchain network, you are responsible for the content you provide. We do not endorse, support, represent or guarantee the completeness, truthfulness, accuracy or reliability of any content posted via the Messaging Services. You understand that by using the Ethereum blockchain network, you may be exposed to content that might be offensive, harmful, inaccurate or otherwise inappropriate, or in some cases, deceptive. All Usergenerated content is the sole responsibility of the person who originated such content. We do not monitor or control the content posted via the Messaging Services and, we cannot take responsibility for such content. Treasure NFT reserves the right to remove content that we determine violates our Terms of Use or we may restrict, suspend, or terminate any User’s use of the Messaging Services, if we determine in our sole and absolute discretion, that such person has used the Messaging Services in a manner that is inconsistent with these Terms of Use and or applicable law.\n\n",
                      style: AppTextStyle.baseStyle()),
                  Text("ALL USERS: MISCELLANEOUS TERMS\n\n",style: AppTextStyle.homeTitleStyle(),),
                  Text("Links to Other Web Sites and Content",style: AppTextStyle.homeTitleStyle(),),
                  Text("The Site contains (or you may be sent through the Site or the Services) links to other web sites (“Third Party Sites”), as well as articles, photographs, text, graphics, pictures, designs, music, sound, video, information, software and other content belonging to or originating from third parties (the “Third Party Content“). Such Third Party Sites and Third Party Content are not investigated, monitored or checked for accuracy, appropriateness, or completeness by us, and we are not responsible for any Third Party Sites accessed through the Site or any Third Party Content posted on the Site, including without limitation the content, accuracy, offensiveness, opinions, reliability or policies of or contained in the Third Party Sites or the Third Party Content. Inclusion of or linking to any Third Party Site or any Third Party Content does not imply approval or endorsement thereof by us. If you decide to leave the Site and access the Third Party Sites, you do so at your own risk and you should be aware that our terms and policies no longer govern. You should review the applicable terms and policies, including privacy and data gathering practices, of any site to which you navigate from the Site.\n\n",
                      style: AppTextStyle.baseStyle()),
                  Text("User Disputes",style: AppTextStyle.homeTitleStyle(),),
                  Text("You are solely responsible for your interactions with other Users. We reserve the right, but have no obligation, to monitor disputes between you and other Users.\n\n",
                      style: AppTextStyle.baseStyle()),
                  Text("Privacy",style: AppTextStyle.homeTitleStyle(),),
                  Text("Please review the Site's Privacy Policy. By using the Site or the Service, you are consenting to have your personal data transferred to and processed in the United Kingdom.\n\n",
                      style: AppTextStyle.baseStyle()),
                  Text("Disclaimers",style: AppTextStyle.homeTitleStyle(),),
                  Text("The Company does not guarantee the accuracy of any User Content or Third Party Content. Although we provide rules for User conduct, we do not control and are not responsible for what Users do on the Site and are not responsible for any offensive, inappropriate, obscene, unlawful or otherwise objectionable content you may encounter on the Site or in connection with any User Content or Third Party Content. The Company is not responsible for the conduct, whether online or offline, of any User of the Site or Service. The Company cannot guarantee and does not promise any specific results from use of the Site and/or the Service.\n"
                    "The Site and the Service may be temporarily unavailable from time to time for maintenance or other reasons. The Company assumes no responsibility for any error, omission, interruption, deletion, defect, delay in operation or transmission, communications line failure, theft or destruction or unauthorized access to, or alteration of, User communications. The Company is not responsible for any problems or technical malfunction of any telephone network or lines, computer online systems, servers or providers, computer equipment, software, failure of email or players on account of technical problems or traffic congestion on the Internet or on the Site or combination thereof, including injury or damage to Users or to any other person's computer related to or resulting from participating or downloading materials in connection with the Web and/or in connection with the Service. Under no circumstances will the Company be responsible for any loss or damage, including any loss or damage to any User Content, financial damages or lost value, loss of business, or personal injury or death, resulting from anyone's use of the Site or the Service, any User Content or Third Party Content posted on or through the Site or the Service or transmitted to Users, or any interactions between Users of the Site, whether online or offline.\n"
                    "The Company reserves the right to change any and all content contained in the Site and any Services offered through the Site at any time without notice. Reference to any products, services, processes or other information, by trade name, trademark, manufacturer, supplier or otherwise does not constitute or imply endorsement, sponsorship or recommendation thereof, or any affiliation therewith, by the Company.\n\n",
                      style: AppTextStyle.baseStyle()),
                  Text("Limitation on Liability",style: AppTextStyle.homeTitleStyle(),),
                  Text("Except in jurisdictions where such provisions are restricted, in no event will the company or its directors, employees or agents be liable to you or any third party for any indirect, consequential, exemplary, incidental, special or punitive damages, including for any lost value or lost data arising from your use of the site or the service or any of the site content or other materials on or accessed through the site, even if the company is aware or has been advised of the possibility of such damages. Notwithstanding anything to the contrary contained herein to the extent permitted by applicable law the company's liability to you for any cause whatsoever, and regardless of the form of the action, will at all times be limited to the amount paid, if any, by you to the company for the service during the term of membership. in no case will the company's liability to you exceed £820. you acknowledge that no fees are paid to the company for the service, you shall be limited to injunctive relief only, unless otherwise permitted by law, and shall not be entitled to damages of any kind from the company, regardless of the cause of action.\n\n",
                      style: AppTextStyle.baseStyle()),
                  Text("Governing Law",style: AppTextStyle.homeTitleStyle(),),
                  Text("These terms and conditions are governed by and construed in accordance with the laws of England and Wales.\n"
                      "Any dispute you have which relates to these terms and conditions, or your use of Treasure NFT (whether it be contractual or non-contractual), will be subject to the exclusive jurisdiction of the courts of England and Wales.\n\n",
                      style: AppTextStyle.baseStyle()),
                  Text("General",style: AppTextStyle.homeTitleStyle(),),
                  Text("There may be legal notices elsewhere on Treasure NFT that relate to how you use the site.\n"
                    "We’re not liable if we fail to comply with these terms and conditions because of circumstances beyond our reasonable control.\n"
                    "We might decide not to exercise or enforce any right available to us under these terms and conditions. We can always decide to exercise or enforce that right at a later date. Doing this once will not mean we automatically waive the right on any other occasion. If any of these terms and conditions are held to be invalid, unenforceable or illegal for any reason, the remaining terms and conditions will still apply.\n\n",
                      style: AppTextStyle.baseStyle()),

                  Text("Changes to these terms and conditions",style: AppTextStyle.homeTitleStyle(),),
                  Text("Please check these terms and conditions regularly. We can update them at any time without notice.\n"
                    "You’ll agree to any changes if you continue to use Treasure NFT after the terms and conditions have been updated.\n\n",
                      style: AppTextStyle.baseStyle()),

                  Text("Indemnity",style: AppTextStyle.homeTitleStyle(),),
                  Text("You agree to indemnify and hold the Company, its subsidiaries and affiliates, and each of their directors, officers, agents, contractors, members, managers, partners and employees, harmless from and against any loss, liability, claim, demand, damages, costs and expenses, including reasonable attorney's fees, arising out of or in connection with your User Content, any Third Party Content you post or share on or through the Site, your use of the Service or the Site, your conduct in connection with the Service or the Site or with other Users of the Service or the Site, or any violation of these Terms of Use or of any law or the rights of any third party. The previous sentence shall not apply to any extent to Users while acting as an investor or while registering as an investor in connection with their (i) posting of User Content or (ii) use of the Site or Service.\n\n",
                      style: AppTextStyle.baseStyle()),
                  Text("Other",style: AppTextStyle.homeTitleStyle(),),
                  Text("The failure of the Company to exercise or enforce any right or provision of these Terms of Use shall not constitute a waiver of such right or provision in that or any other instance. If any provision of these Terms of Use is held invalid, the remainder of these Terms of Use shall continue in full force and effect. If any provision of these Terms of Use shall be deemed unlawful, void or for any reason unenforceable, then that provision shall be deemed severable from these Terms of Use and shall not affect the validity and enforceability of any remaining provisions.\n\n",
                      style: AppTextStyle.baseStyle()),
                ],
              ),
            ),
          ),
        ],
      ),

    );
  }
  const HomeTermsOfUs({Key? key}) : super(key: key);
}
