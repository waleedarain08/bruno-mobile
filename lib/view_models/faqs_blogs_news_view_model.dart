import 'package:brunos_kitchen/models/base_response_model.dart';
import 'package:brunos_kitchen/models/requests/feedback_request.dart';
import 'package:brunos_kitchen/models/responses/blogs_news_response.dart';
import 'package:brunos_kitchen/models/responses/faqs_blogs_news_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../services/faqs_blogs_news_api_services.dart';

class FaqsBlogsNewsViewModel with ChangeNotifier {
  final FaqsBlogsNewsApiServices _faqsBlogsNewsApiServices =
      FaqsBlogsNewsApiServices();
  FaqsBlogsNewsResponse _faqsResponse = FaqsBlogsNewsResponse();
  BlogsNewsResponse _blogsNewsResponse = BlogsNewsResponse();
  BlogsNewsData _selectedBlogNews = BlogsNewsData();
  final TextEditingController _feedbackTitle = TextEditingController();
  final TextEditingController _feedbackDesc = TextEditingController();
  final TextEditingController _comment = TextEditingController();

  BlogsNewsData get getSelectedBlogNews => _selectedBlogNews;

  void setSelectedBlogNews(BlogsNewsData data) {
    _selectedBlogNews = data;
    notifyListeners();
  }

  TextEditingController get getFeedbackTitle => _feedbackTitle;

  TextEditingController get getFeedbackDesc => _feedbackDesc;
  TextEditingController get getComment => _comment;

  BlogsNewsResponse get getBlogsNewsResponse => _blogsNewsResponse;

  void setBlogsNewsResponse(BlogsNewsResponse value) {
    _blogsNewsResponse = value;
    notifyListeners();
  }

  FaqsBlogsNewsResponse get getFaqsResponse => _faqsResponse;

  void setFaqsResponse(FaqsBlogsNewsResponse value) {
    _faqsResponse = value;
    notifyListeners();
  }

  Future<bool> callFaqsApi() async {
    EasyLoading.show(status: 'Please Wait ...');
    try {
      final FaqsBlogsNewsResponse response =
          await _faqsBlogsNewsApiServices.allFaqsApi();
      if (response.isSuccess!) {
        setFaqsResponse(response);
        EasyLoading.dismiss();
        return true;
      } else {
        EasyLoading.showError('${response.message}');
        return false;
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
      return false;
    }
  }

  bool validateFeedbackForm() {
    if (_feedbackTitle.text.isEmpty || _feedbackDesc.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  bool validateComment() {
    if (_comment.text.isEmpty || _comment.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  clearBlogNewsData() {
    if (_blogsNewsResponse.data != null) {
      _blogsNewsResponse.data!.clear();
      notifyListeners();
    }
  }

  clearComment() {
    _comment.clear();
  }

  clearFeedbackForm() {
    _feedbackDesc.clear();
    _feedbackTitle.clear();
  }

  Future<bool> callAddFeedbackApi() async {
    EasyLoading.show(status: 'Please Wait ...');
    try {
      final BaseResponseModel response =
          await _faqsBlogsNewsApiServices.addFeedbackApi(
              feedbackRequest: FeedbackRequest(
                  title: _feedbackTitle.text,
                  description: _feedbackDesc.text,
                  type: 'feedback'));
      if (response.isSuccess!) {
        clearFeedbackForm();
        EasyLoading.showSuccess('Feedback Submitted Successfully');
        return true;
      } else {
        EasyLoading.showError('${response.message}');
        return false;
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
      return false;
    }
  }

  Future<bool> callAddCommentApi() async {
    EasyLoading.show(status: 'Please Wait ...');
    try {
      final BaseResponseModel response =
          await _faqsBlogsNewsApiServices.addFeedbackApi(
              feedbackRequest: FeedbackRequest(
                  title: 'Get Help Comment',
                  description: _comment.text,
                  type: 'feedback'));
      if (response.isSuccess!) {
        clearFeedbackForm();
        EasyLoading.showSuccess('Comment Submitted Successfully');
        return true;
      } else {
        EasyLoading.showError('${response.message}');
        return false;
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
      return false;
    }
  }

  Future<bool> callNewsApi() async {
    clearBlogNewsData();
    EasyLoading.show(status: 'Please Wait ...');
    try {
      final BlogsNewsResponse response =
          await _faqsBlogsNewsApiServices.allNewsApi();
      if (response.isSuccess!) {
        setBlogsNewsResponse(response);
        EasyLoading.dismiss();
        return true;
      } else {
        EasyLoading.showError('${response.message}');
        return false;
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
      return false;
    }
  }

  Future<bool> callBlogsApi() async {
    clearBlogNewsData();
    EasyLoading.show(status: 'Please Wait ...');
    try {
      final BlogsNewsResponse response =
          await _faqsBlogsNewsApiServices.allBlogsApi();
      if (response.isSuccess!) {
        setBlogsNewsResponse(response);
        EasyLoading.dismiss();
        return true;
      } else {
        EasyLoading.showError('${response.message}');
        return false;
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
      return false;
    }
  }
}
