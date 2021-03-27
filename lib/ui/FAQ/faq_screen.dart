import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/ui/FAQ/faq.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/components/error_widget.dart';
import 'package:appetizer/ui/components/progress_bar.dart';
import 'package:appetizer/viewmodels/faq_models/faq_model.dart';
import 'package:flutter/material.dart';

class FaqList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<FaqModel>(
      onModelReady: (model) => model.getFaqs(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            'FAQs',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SafeArea(
          child: model.state == ViewState.Busy
              ? ProgressBar()
              : model.state == ViewState.Error
                  ? AppiErrorWidget(message: model.errorMessage)
                  : ListView.builder(
                      itemCount: model.faqs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Faq(
                          question: model.faqs[index].question,
                          answer: model.faqs[index].answer,
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
