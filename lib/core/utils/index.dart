// Plattformübergreifende Importe
export 'package:flutter/material.dart';
export 'package:flutter/foundation.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:pdf/pdf.dart';
export 'package:printing/printing.dart';
export 'dart:typed_data';


export 'package:foundational_learning_platform/core/extensions/hover_extensions_web.dart'
if (dart.library.html) 'package:foundational_learning_platform/core/extensions/hover_extensions_web.dart';


export 'dart:io' if (dart.library.io) 'dart:io';

export 'package:path_provider/path_provider.dart' if (dart.library.io) '';


export 'package:foundational_learning_platform/features/turing_machine/utils/turinmachine_utils.dart';
export 'package:foundational_learning_platform/features/turing_machine/presentation/pages/tm_start_options.dart';
export 'package:foundational_learning_platform/features/turing_machine/presentation/widgets/details_dialog.dart';
export 'package:foundational_learning_platform/features/turing_machine/presentation/widgets/build_transion_rule_widget.dart';
export 'package:foundational_learning_platform/features/turing_machine/presentation/bloc/selectable_list/tm_selectable_list_bloc.dart';
export 'package:foundational_learning_platform/features/turing_machine/domain/entities/turing_machine.dart';
export 'package:foundational_learning_platform/features/turing_machine/domain/entities/transition_function.dart';
export 'package:foundational_learning_platform/features/turing_machine/domain/entities/movement_direction.dart';
export 'package:foundational_learning_platform/features/turing_machine/domain/entities/executionState.dart';
export 'package:foundational_learning_platform/core/utils/utils.dart';
export 'package:foundational_learning_platform/core/utils/abstract/MyTransitionAbstract.dart';
export 'package:foundational_learning_platform/core/utils/MyStack.dart';
export 'package:foundational_learning_platform/core/shared/widgets/selecatble_list_widget.dart';
export 'package:foundational_learning_platform/core/shared/widgets/dynamicBand_widget.dart';
export 'package:foundational_learning_platform/core/shared/widgets/custom_textFormField_widget.dart';
export 'package:foundational_learning_platform/core/shared/widgets/custom_slider_widget.dart';
export 'package:foundational_learning_platform/core/shared/widgets/custom_container_widget.dart';
export 'package:foundational_learning_platform/core/shared/widgets/custom_container_shadow_widget.dart';
export 'package:foundational_learning_platform/core/shared/widgets/custom_container_circle_widget.dart';
export 'package:foundational_learning_platform/core/shared/stepper/widgets/stepper_widget.dart';
export 'package:foundational_learning_platform/core/shared/stepper/bloc/step_progress_bloc.dart';
export 'package:foundational_learning_platform/core/shared/quiz/bloc/quiz_bloc.dart';
export 'package:foundational_learning_platform/core/shared/bloc/sidebar/sidebar_state.dart';
export 'package:foundational_learning_platform/core/shared/bloc/sidebar/sidebar_bloc.dart';
export 'package:foundational_learning_platform/core/shared/bloc/single_selection/single_selection_bloc.dart';
export 'package:foundational_learning_platform/core/shared/bloc/hover/hover_bloc.dart';
export 'package:foundational_learning_platform/core/shared/bloc/dynamic_Band/dynamic_band_bloc.dart';
export 'package:foundational_learning_platform/core/shared/bloc/animation/animation_bloc.dart';
export 'package:foundational_learning_platform/core/baseComponents/contentBlockWidget.dart';
export 'dart:convert';
export 'dart:async';
export 'package:bloc/bloc.dart';
export 'package:foundational_learning_platform/core/shared/card/widgets/MyCard.dart';
export 'package:foundational_learning_platform/core/shared/widgets/homeContentWidget.dart';
export 'package:foundational_learning_platform/core/shared/sideBar/sideBar_widget.dart';
export 'package:foundational_learning_platform/core/shared/widgets/custom_typeWriter_widget.dart';
export 'package:foundational_learning_platform/core/shared/pages/Home.dart';
export 'package:foundational_learning_platform/features/turing_machine/presentation/pages/TM.dart';
export 'package:foundational_learning_platform/core/shared/bloc/content/content_bloc.dart';
export 'package:foundational_learning_platform/core/shared/bloc/sidebar/sidebar_event.dart';
export 'package:flutter_gradients_reborn/flutter_gradients_reborn.dart';
export 'package:foundational_learning_platform/core/shared/widgets/translate_on_hover.dart';
export 'package:foundational_learning_platform/core/config/constants/AppContents.dart';
export 'package:foundational_learning_platform/core/config/theme/AppColors.dart';
export 'package:foundational_learning_platform/core/config/theme/appDimensions.dart';
export 'package:foundational_learning_platform/core/config/theme/app_theme.dart';
export 'package:foundational_learning_platform/core/config/theme/AppIcons.dart';
export 'package:foundational_learning_platform/core/config/theme/appTextStyles.dart';
export 'package:foundational_learning_platform/core/config/theme/appGradientsTheme.dart';
export 'package:foundational_learning_platform/features/turing_machine/presentation/widgets/buildStateSelectionwidget.dart';
export 'package:foundational_learning_platform/core/config/theme/buttons/custom_elevatedButton.dart';
export 'package:foundational_learning_platform/core/utils/global_enums/states/ControlActions.dart';
export 'package:foundational_learning_platform/core/shared/widgets/custom_singleExpansionPanel_widget.dart';
export 'package:foundational_learning_platform/features/turing_machine/presentation/bloc/reportWidget/report_bloc.dart';
export 'package:foundational_learning_platform/core/error/noDataPage.dart';
export 'package:equatable/equatable.dart';
export 'package:foundational_learning_platform/features/turing_machine/domain/entities/local_tm_list.dart';
export 'package:foundational_learning_platform/core/error/turing_machine_load_exception.dart';
export 'package:foundational_learning_platform/core/error/turing_machine_notFound_exception.dart';
export 'package:foundational_learning_platform/features/turing_machine/domain/repositories/turing_machine_repository.dart';
export 'package:foundational_learning_platform/features/turing_machine/data/datasources/turing_machine_local_data_source.dart';
export 'package:uuid/uuid.dart';
export 'package:shared_preferences/shared_preferences.dart';
export 'package:foundational_learning_platform/features/turing_machine/data/repositories/TuringMachineRepositoryImpl.dart';
export 'package:foundational_learning_platform/features/turing_machine/presentation/bloc/turingMachine_Bloc/turing_machine_bloc.dart';
export 'package:foundational_learning_platform/core/utils/global_enums/states/ApprovalState.dart';
export 'package:foundational_learning_platform/features/turing_machine/domain/usescases/ExecuteTransitionUseCase.dart';
export 'package:foundational_learning_platform/features/turing_machine/domain/usescases/InitializeTuringMachineUseCase.dart';
export 'package:foundational_learning_platform/features/turing_machine/presentation/dialog/showResultDialog.dart';
export 'package:foundational_learning_platform/features/turing_machine/presentation/widgets/reportWidget.dart';
export 'package:foundational_learning_platform/core/utils/global_enums/states/StepperState.dart';
export 'package:foundational_learning_platform/features/turing_machine/domain/usescases/HandleStepContinueUseCase.dart';
export 'package:foundational_learning_platform/features/turing_machine/presentation/widgets/stepper_tm_conf/step1_widget.dart';
export 'package:foundational_learning_platform/features/turing_machine/presentation/widgets/stepper_tm_conf/step2_widget.dart';
export 'package:foundational_learning_platform/features/turing_machine/presentation/widgets/stepper_tm_conf/step3_widget.dart';
export 'package:foundational_learning_platform/features/turing_machine/presentation/widgets/stepper_tm_conf/step4_widget.dart';
export 'package:foundational_learning_platform/features/turing_machine/domain/usescases/UpdateAlphabetUseCase.dart';
export 'package:foundational_learning_platform/features/turing_machine/domain/usescases/UpdateStatesUseCase.dart';
export 'package:foundational_learning_platform/features/turing_machine/domain/usescases/InitializeStatesUseCase.dart';
export 'package:foundational_learning_platform/core/config/theme/buttons/custom_backButton.dart';
export 'package:foundational_learning_platform/features/turing_machine/presentation/widgets/stepper_tm_conf/build_stepper_widget.dart';
export 'package:foundational_learning_platform/core/utils/global_enums/states/EditingState.dart';
export 'package:foundational_learning_platform/features/turing_machine/domain/usescases/CheckForDuplicatesUseCase.dart';
export 'package:foundational_learning_platform/features/turing_machine/domain/usescases/IsRuleCompleteUseCase.dart';
export 'package:foundational_learning_platform/features/turing_machine/domain/usescases/CanAddNewRuleUseCase.dart';
export 'package:foundational_learning_platform/core/shared/widgets/custom_dropdownField.dart';
export 'package:foundational_learning_platform/features/turing_machine/domain/usescases/GetCircleAvatarColorUseCase.dart';
export 'package:foundational_learning_platform/features/turing_machine/domain/usescases/UpdateTransitionRuleUseCase.dart';
export 'package:foundational_learning_platform/features/turing_machine/presentation/pages/simulator/execution_page.dart';
export 'package:foundational_learning_platform/features/turing_machine/presentation/pages/simulator/turing_configuration.dart';
export 'package:foundational_learning_platform/features/turing_machine/presentation/widgets/BuildSpeedControls.dart';
export 'package:foundational_learning_platform/features/turing_machine/presentation/widgets/custom_table_widget.dart';
export 'package:flutter/services.dart' show rootBundle;
export 'package:flutter_animate/flutter_animate.dart';
export 'package:flutter_svg/svg.dart';
export 'package:foundational_learning_platform/core/config/responsive_Layout.dart';
export 'package:lottie/lottie.dart';
export 'package:flutter/services.dart';
export 'package:typewrite_text/typewrite_text.dart';
export 'package:foundational_learning_platform/features/turing_machine/presentation/widgets/buildInputField.dart';







