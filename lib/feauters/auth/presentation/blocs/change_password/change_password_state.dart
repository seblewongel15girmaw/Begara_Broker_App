abstract class ChangePasswordState{}

class Idle extends ChangePasswordState{}

class ChangingPassword extends ChangePasswordState{}

class ChangePasswordFailed extends ChangePasswordState{}

class ChangePasswordSuccess extends ChangePasswordState{}