// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract Storage {
  // Структура произвольного содержания
  struct MyStruct {
      uint256 number;
      string name;
      address owner;
      bool isActive;
  }

  // Отображение ключа на значение (структура)
  mapping(uint256 => MyStruct) public myMapping;

  // Событие для отслеживания добавления структуры
  event StructureAdded(uint256 key, uint256 number, string name, address owner, bool isActive);

  // Событие для отслеживания удаления структуры
  event StructureRemoved(uint256 key);

  // Функция добавления структуры в отображение
  function addStructure(uint256 key, uint256 number, string memory name, bool isActive) external {
      require(myMapping[key].owner == address(0), "Key already exists");
      
      MyStruct memory newStruct = MyStruct({
          number: number,
          name: name,
          owner: msg.sender,
          isActive: isActive
      });

      myMapping[key] = newStruct;

      // Отправляем событие добавления структуры
      emit StructureAdded(key, number, name, msg.sender, isActive);
  }

  // Функция удаления структуры из отображения
  function removeStructure(uint256 key) external {
      require(myMapping[key].owner == msg.sender, "You are not the owner");

      // Удаляем структуру из отображения
      delete myMapping[key];

      // Отправляем событие удаления структуры
      emit StructureRemoved(key);
  }
  
}
