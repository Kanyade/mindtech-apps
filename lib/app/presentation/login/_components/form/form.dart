part of '../../screen.dart';

class _LoginForm extends HookWidget with TextFieldHooksMixin {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthenticationBloc>();
    final emailHooks = useTextFieldHooks();
    final passwordHooks = useTextFieldHooks();
    final formKey = useMemoized(GlobalKey<FormState>.new, []);

    return Form(
      key: formKey,
      child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationErrorState) {
            showSnackbar(
              context: context,
              type: SnackbarType.error,
              text: switch (state.exception) {
                AuthenticationError.UnknownException => 'Something went wrong, please try again.'.hardCoded,
                AuthenticationError.InvalidPasswordException => 'Invalid password, please try again.'.hardCoded,
                AuthenticationError.NotAuthorizedException => 'You are not allowed to do that.'.hardCoded,
                AuthenticationError.UserNotFoundException => 'User not found, please check your email.'.hardCoded,
                AuthenticationError.TooManyRequestsException => 'Too many attempts. Try again later.'.hardCoded,
              },
            );
          }
        },
        listenWhen: (old, current) => old is AuthenticationLoadingState && current is AuthenticationErrorState,
        bloc: authBloc,
        builder: (context, state) {
          final fieldsEnabled = state is! AuthenticationLoadedState;

          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  spacing: AppDimensions.h24,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login'.hardCoded,
                      style: AppTextStyles.mobileHeadersHeaderMobile3.copyWith(color: AppColors.primary),
                    ),
                    _EmailField(
                      enabled: fieldsEnabled,
                      hooks: emailHooks,
                      autoValidate: state is AuthenticationErrorState,
                    ),
                    _PasswordField(
                      enabled: fieldsEnabled,
                      passwordHooks: passwordHooks,
                      autoValidate: state is AuthenticationErrorState,
                    ),
                    _FormButtons(
                      formKey: formKey,
                      emailController: emailHooks.controller,
                      passwordController: passwordHooks.controller,
                    ),
                  ],
                ),
              ),
              if (!fieldsEnabled)
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                    child: const CircularProgressIndicator.adaptive(),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
