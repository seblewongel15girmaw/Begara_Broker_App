abstract class CreateHouseState{}

class IdleHouse extends CreateHouseState{}

class CreatingHouse extends CreateHouseState{}

class CreateHouseSuccess extends CreateHouseState{}

class CreateHouseFailure extends CreateHouseState{}