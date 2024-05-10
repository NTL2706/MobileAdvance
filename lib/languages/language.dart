import 'package:flutter/widgets.dart';

abstract class Languages {
  static Languages? of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  String get appName;

  String get slotGen;

  String get appDescription;

  String get appDescription2;

  String get cancel;
  String get save;
  String get oke;
  String get update;
  String get error;
  String get edit;
  String get delete;
  String get create;
  String get saved;
  String get next;

  // page profile
  String get profile;
  String get switchAccount;
  String get setting;
  String get logout;
  String get changeLanguage;
  String get changePassword;
  String get addCompany;
  String get addStudent;
  String get cvAndTranscript;
  String get experience;
  String get detailExp;
  String get techStack;
  String get skill;
  String get education;
  String get student;
  String get company;
  String get editEducation;
  String get schoolName;
  String get startYear;
  String get endYear;
  String get oldPW;
  String get newPW;
  String get confirmPW;
  String get pW;
  String get projects;
  String get numberOfEmployees;
  String get name;
  String get address;
  String get website;
  String get description;
  String get updateCompany;
  String get startTime;
  String get endTime;
  String get updateCompanyDescription;
  String get errorMissingField;

  // page auth
  String get forgotPassword;
  String get login;
  String get register;
  String get email;
  String get getIt;
  String get dontAccount;
  String get selectCategorySignUp;
  String get iIs;
  String get fullName;
  String get agree;
  String get lookProject;
  String get apply;

  // page chat
  String get search;
  String get scheduleMeeting;
  String get typeHere;
  String get createdBy;
  String get duration;
  String get cancelMeeting;
  String get join;
  String get pickDateAndTime;

  // page alert
  String get all;
  String get interview;
  String get message;
  String get other;
  String get startInterview;
  String get goChat;

  // page dashboard
  String get dashboard;
  String get allProject;
  String get working;
  String get archive;
  String get proposal;
  String get hired;
  String get postJob;
  String get alert;
  String get viewProposal;
  String get viewMessage;
  String get viewHired;
  String get viewJobPosting;
  String get exitPosting;
  String get removePosting;
  String get startWorking;
  String get lookingFor;

  // page home
  String get searchProject;
  String get created;
  String get time;
  String get studentNeed;
  String get details;
  String get viewDetails;
  String get applyProject;
  String get applyText;
  String get descriptionText;
  String get enterDescription;
  String get sendedSuccess;
  String get sendedFail;
  String get hiredOffer;
  String get hiredOfferDescription;

  // page post job
  String get postJobDescription;
  String get letStart;
  String get exampleTitle;
  String get example1;
  String get example2;

  String get letStart2;
  String get postDescription2;
  String get questionProjectTake;
  String get questionStudentNeed;
  String get timeTake1;
  String get timeTake2;
  String get timeTake3;
  String get timeTake4;

  String get letStart3;
  String get postDescription3;
  String get example3;
  String get example4;
  String get example5;
  String get noChange;
  String get review;
  String get addJob;
}
