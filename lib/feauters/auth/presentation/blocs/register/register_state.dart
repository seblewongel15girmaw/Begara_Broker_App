abstract class RegisterState{}
class IdleRegister extends RegisterState{}
class Registering extends RegisterState{}
class RegisterFailed extends RegisterState{}
class RegisterSuccess extends RegisterState{}
class ProfileNotSelected extends RegisterState{}
class VerificationSuccess extends RegisterState{}
class VerificationFailed extends RegisterState{}