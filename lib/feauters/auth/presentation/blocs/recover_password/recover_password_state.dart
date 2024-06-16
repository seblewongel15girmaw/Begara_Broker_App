abstract class RecoverPasswordState{}

class Idle extends RecoverPasswordState{}

class RecoveringPassword extends RecoverPasswordState{}

class SuccessfulyRecovered extends RecoverPasswordState{}

class RecoverFailed extends RecoverPasswordState{}