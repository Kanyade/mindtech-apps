part of '../../screen.dart';

class _FormButtons extends StatelessWidget {
  const _FormButtons({required this.formKey, required this.emailController, required this.passwordController});

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppButton.filled(
          label: Text('Login'.toUpperCase().hardCoded),
          paddingStyle: ButtonPaddingStyle.spacious,
          isFullWidth: true,
          onPressed: () {
            if (formKey.currentState!.validate()) {
              context.read<AuthenticationBloc>().add(
                AuthenticationLoginEvent(email: emailController.text, password: passwordController.text),
              );
            }
          },
        ),
        AppButton.text(
          label: Text('No account yet? Create now!'.hardCoded),
          variant: TextButtonVariant.gray,
          onPressed: () {},
        ),
        AppButton.filled(
          label: Text('Registration'.toUpperCase().hardCoded),
          paddingStyle: ButtonPaddingStyle.spacious,
          isFullWidth: true,
          onPressed: null,
        ),
      ],
    );
  }
}
