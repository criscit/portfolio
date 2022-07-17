"""Реализуйте базовый класс Car. У данного класса должны быть следующие атрибуты:
speed, color, name, is_police (булево). А также методы: go, stop, turn(direction),
которые должны сообщать, что машина поехала, остановилась, повернула (куда).
Опишите несколько дочерних классов: TownCar, WorkCar, PoliceCar.
Добавьте в базовый класс метод show_speed, который должен показывать текущую скорость автомобиля.
Для классов TownCar и WorkCar переопределите метод show_speed. При значении скорости свыше 60 (TownCar) и 40 (WorkCar)
должно выводиться сообщение о превышении скорости."""


class Car:
    speed: int
    color: str
    name: str
    is_police: bool = False

    def __init__(self, speed: int, color: str, name: str):
        self.speed = speed
        self.color = color
        self.name = name

    def go(self):
        print(f"{self.name}: старт")

    def stop(self):
        print(f"{self.name}: стоп")

    def turn(self, direction: str):
        print(f"{self.name}: поворот - {direction}")

    def show_speed(self):
        print(f"{self.name}: скорость = {self.speed} км/ч")


class TownCar(Car):
    def show_speed(self):
        super().show_speed()
        if self.speed > 60:
            print(f"{self.name}: скорость превышена")


class WorkCar(Car):
    def show_speed(self):
        super().show_speed()
        if self.speed > 40:
            print(f"{self.name}: скорость превышена")


class PoliceCar(Car):
    is_police: bool = True


"""Реализовать базовый класс Worker (работник), в котором определить атрибуты:
name, surname, position (должность), income (доход).
Последний атрибут должен быть защищенным и ссылаться на словарь, содержащий элементы: оклад и премия,
например, {"wage": wage, "bonus": bonus}. Создать класс Position (должность) на базе класса Worker.
В классе Position реализовать методы получения полного имени сотрудника (get_full_name)
и дохода с учетом премии (get_total_income).
Проверить работу примера на реальных данных
(создать экземпляры класса Position, передать данные, проверить значения атрибутов, вызвать методы экземпляров)."""


class Worker:
    name: str
    surname: str
    position: str
    _income: dict

    def __init__(self, name: str, surname: str, position: str, wage: int, bonus: int):
        self.name = name
        self.surname = surname
        self.position = position
        self.wage = wage
        self._income = {"wage": wage, "bonus": bonus}


class Position(Worker):
    def get_full_name(self):
        return f"{self.name} {self.surname}"

    def get_total_income(self):
        return sum(self._income.values())


"""Реализовать класс Road (дорога), в котором определить атрибуты: length (длина), width (ширина).
Значения данных атрибутов должны передаваться при создании экземпляра класса. Атрибуты сделать защищенными.
Определить метод расчета массы асфальта, необходимого для покрытия всего дорожного полотна.
Использовать формулу: длина*ширина*масса асфальта для покрытия одного кв метра дороги асфальтом,
толщиной в 1 см*число см толщины полотна. Проверить работу метода."""


class Road:
    __mass: float = 25
    _width: float
    _length: float

    def __init__(self, width: float, length: float):
        self._width = width
        self._length = length

    def asphalt_mass(self, depth: float = 1):
        return self._length * self._width * self.__mass * depth / 1000


road = Road(20, 5000)
print(f"{road.asphalt_mass(5)} т")

"""Создать класс TrafficLight (светофор) и определить у него один атрибут color (цвет) и метод running (запуск).
Атрибут реализовать как приватный.
В рамках метода реализовать переключение светофора в режимы: красный, желтый, зеленый.
Продолжительность первого состояния (красный) составляет 7 секунд,
второго (желтый) — 2 секунды, третьего (зеленый) — на ваше усмотрение.
Переключение между режимами должно осуществляться только в указанном порядке (красный, желтый, зеленый).
Проверить работу примера, создав экземпляр и вызвав описанный метод.
Задачу можно усложнить, реализовав проверку порядка режимов,
и при его нарушении выводить соответствующее сообщение и завершать скрипт."""
import time


class TrafficLight:
    __color: str
    __timing: dict
    __next_idx: int = 0

    def __init__(self, red_time: int = 7, yellow_time: int = 2, green_time: int = 5):
        self.__timing = {"красный": red_time, "желтый": yellow_time, "зеленый": green_time}

    def running(self, color: str):
        if list(self.__timing.keys()).index(color) != self.__next_idx:
            print("Неправильный порядок сигналов")
            exit()
        self.__color = color
        timer = self.__timing[color]
        for second in range(timer):
            print(f"{self} [{second + 1}]")
            time.sleep(1)
        next_idx = self.__next_idx + 1
        self.__next_idx = next_idx if next_idx < len(self.__timing) else 0

    def __repr__(self):
        return f"текущий режим = {self.__color}"


try:
    traffic_light = TrafficLight(3, 2, 3)
    traffic_light.running("красный")
    traffic_light.running("желтый")
    traffic_light.running("зеленый")
    traffic_light.running("красный")
    traffic_light.running("зеленый")
except KeyboardInterrupt:
    print("Exit the program")
