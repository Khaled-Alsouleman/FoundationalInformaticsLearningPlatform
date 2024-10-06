import 'package:foundational_learning_platform/core/utils/index.dart';


class TMStartOptionPage extends StatefulWidget {
  const TMStartOptionPage({super.key});

  @override
  _TMStartOptionPageState createState() => _TMStartOptionPageState();
}

class _TMStartOptionPageState extends State<TMStartOptionPage> {
  final ScrollController _scrollController = ScrollController();
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final colorsTheme = Theme.of(context).extension<AppColorsTheme>()!;
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<TuringMachineBloc, TuringMachineState>(
      builder: (context, tmState) {

        if (tmState is TuringMachineLoaded) {
          final tmList = tmState.localTMs;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(AppDimensions.paddingMedium),
                child: CustomBackButton(
                    onPressed: (){
                      context.read<ContentBloc>().add(UpdateContent(context: context, newContent: const TMPage()));
                    }
                ),
              ),
              const SizedBox(height: AppDimensions.paddingLarge,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RoundedShadowContainer(
                    height: screenSize.height - 150,
                    width: screenSize.width  -150,
                    child: Padding(
                      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
                      child: Material(
                        color: colorsTheme.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: AppDimensions.paddingLarge),
                            Expanded(
                              child: tmList.isEmpty ?
                               SizedBox(
                                 width: MediaQuery.of(context).size.width - 30 ,
                                 height: MediaQuery.of(context).size.height - 30,
                                  child:  const NoDataPage()
                              )
                                  :Scrollbar(
                                controller:  _scrollController,
                                child: ListView.builder(
                                  controller: _scrollController,
                                  itemCount: tmList.length,
                                  itemBuilder: (context, index) {
                                    final tm = tmList[index];
                                    return BlocBuilder<SingleSelectionBloc<LocalTMList>, SingleSelectionState<LocalTMList>>(
                                      builder: (context, state) {
                                        LocalTMList? selectedValue = state is SingleSelectionUpdated<LocalTMList>
                                            ? state.selectedItem
                                            : null;
                                        final isSelected = selectedValue == tm;

                                        return Padding(
                                          padding: const EdgeInsets.only(left: 16, right: 16),
                                          child: Card(
                                            color: isSelected
                                                ? colorsTheme.primaryColor
                                                : colorsTheme.white,
                                            child: ListTile(
                                              title: Text(tm.name, style: textTheme.labelLarge!.copyWith(color: isSelected  ?  colorsTheme.white : colorsTheme.primaryColor)),
                                              subtitle: Text(tm.description, style: textTheme.labelMedium!.copyWith(color: isSelected  ?  colorsTheme.white : colorsTheme.primaryColor)),
                                              onTap: () {
                                                context.read<SingleSelectionBloc<LocalTMList>>().add(SingleSelectItemEvent(selectedItem: tm));
                                              },
                                              selected: isSelected,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),

                            const SizedBox(height: AppDimensions.paddingLarge * 2),

                            // Buttons zur Navigation
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomButton(
                                  child: const Text('Weiter mit der ausgewählten TM'),
                                  onPressed: () {
                                    final singleState = context.read<SingleSelectionBloc<LocalTMList>>().state;
                                    if (singleState is SingleSelectionUpdated<LocalTMList>) {
                                      context.read<ContentBloc>().add(UpdateContent(
                                        context: context,
                                        newContent: ExecutionPage(
                                          tm: singleState.selectedItem.tm,
                                          input: '',
                                        ),
                                      ));
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Bitte wählen Sie eine TM aus.'),
                                        ),
                                      );
                                    }
                                  },
                                ),
                                CustomButton(
                                  child: const Text('Neue TM konfigurieren'),
                                  onPressed: () {
                                    context.read<ContentBloc>().add(UpdateContent(
                                      context: context,
                                      newContent: const TMConfiguration(),
                                    ));
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }  else {
          return const Text('Keine Turing-Maschinen verfügbar');
        }
      },
    );
  }
}
