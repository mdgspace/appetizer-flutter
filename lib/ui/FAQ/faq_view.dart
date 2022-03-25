import 'package:appetizer/app_theme.dart';
import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/models/transaction/faq.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/components/appetizer_app_bar.dart';
import 'package:appetizer/ui/components/appetizer_error_widget.dart';
import 'package:appetizer/ui/components/appetizer_progress_widget.dart';
import 'package:appetizer/viewmodels/faq/faq_viewmodel.dart';
import 'package:flutter/material.dart';

class FaqView extends StatelessWidget {
  static const String id = 'faq_view';

  Widget _buildFaq(Faq faq) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Q.  ${faq.question}',
                style: AppTheme.headline5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'A.  ${faq.answer}',
                style: AppTheme.subtitle1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<FaqViewModel>(
      onModelReady: (model) => model.getFaqs(),
      builder: (context, model, child) => Scaffold(
        appBar: AppetizerAppBar(title: 'FAQs'),
        body: () {
          switch (model.state) {
            case ViewState.Idle:
              return ListView.separated(
                itemCount: model.faqs.length,
                itemBuilder: (context, index) => _buildFaq(model.faqs[index]),
                separatorBuilder: (context, index) => Divider(height: 16),
              );

            case ViewState.Busy:
              return AppetizerProgressWidget();

            case ViewState.Error:
              return AppetizerErrorWidget(
                errorMessage: model.errorMessage,
                onRetryPressed: () => model.getFaqs(),
              );

            default:
              return Container();
          }
        }(),
      ),
    );
  }
}
