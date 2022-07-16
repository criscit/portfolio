"""Реализовать класс Stationery (канцелярская принадлежность).
Определить в нем атрибут title (название) и метод draw (отрисовка). Метод выводит сообщение “Запуск отрисовки.”
Создать три дочерних класса Pen (ручка), Pencil (карандаш).
В каждом из классов реализовать переопределение метода draw.
Для каждого из классов метод должен выводить уникальное сообщение.
Создать экземпляры классов и проверить, что выведет описанный метод для каждого экземпляра."""


class Stationery:
    def __init__(self, title):
        self.title = title

    def draw(self):
        print(f"Запуск отрисовки с помощью {self.title}")


class Pen(Stationery):
    def __init__(self):
        super().__init__("pen")

    def draw(self):
        print(f"Запуск отрисовки с помощью {self.title}")


class Pencil(Stationery):
    def __init__(self):
        super().__init__("pencil")

    def draw(self):
        print(f"Запуск отрисовки с помощью {self.title}")


"""Реализуйте базовый класс Car. У данного класса должны быть следующие атрибуты:
speed, color, name, is_police (булево). А также методы: go, stop, turn(direction),
которые должны сообщать, что машина поехала, остановилась, повернула (куда).
Опишите несколько дочерних классов: TownCar, WorkCar, PoliceCar.
Добавьте в базовый класс метод show_speed, который должен показывать текущую скорость автомобиля.
Для классов TownCar и WorkCar переопределите метод show_speed. При значении скорости свыше 60 (TownCar) и 40 (WorkCar)
должно выводиться сообщение о превышении скорости."""


class Car:
    is_police = False

    def __init__(self, speed, color, name):
        self.speed = speed
        self.color = color
        self.name = name

    def go(self):
        print("Машина едет")

    def stop(self):
        print("Машина остановилась")

    def turn(self, direction):
        print(f"Машина поеврнула {direction}")

    def show_speed(self):
        print(f"Скорость {self.speed}")


class TownCar(Car):
    def show_speed(self):
        if self.speed > 60:
            print(f"Скорость превышена")
        else:
            print(f"Скорость {self.speed}")


class WorkCar(Car):
    def show_speed(self):
        if self.speed > 40:
            print(f"Скорость превышена")
        else:
            print(f"Скорость {self.speed}")


class PoliceCar(Car):
    is_police = True


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

    def __init__(self, name, surname, position, wage, bonus):
        self.name = name
        self.surname = surname
        self.position = position
        self.wage = wage
        self._income = {"wage": wage, "bonus": bonus}


class Position(Worker):
    def get_full_name(self):
        full_name = f"{self.name} {self.surname}"
        return full_name

    def get_total_income(self):
        income = sum(self._income.values())
        return income


a = Position("name", "surname", "position", 150, 15)
print(a.get_full_name())
print(a.get_total_income())

"""Реализовать класс Road (дорога), в котором определить атрибуты: length (длина), width (ширина).
Значения данных атрибутов должны передаваться при создании экземпляра класса. Атрибуты сделать защищенными.
Определить метод расчета массы асфальта, необходимого для покрытия всего дорожного полотна.
Использовать формулу: длина*ширина*масса асфальта для покрытия одного кв метра дороги асфальтом,
толщиной в 1 см*число см толщины полотна. Проверить работу метода."""


class Road:
    _length: int
    _width: int

    def __init__(self, length, width):
        self._length = length
        self._width = width

    def asphalt_mass(self, mass_standard, thickness):
        mass = self._length * self._width * mass_standard * thickness
        return mass


road = Road(20, 5000)
print(road.asphalt_mass(25, 5))

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
    __color: str = ""

    def running(self):
        start = time.time()
        counter = time.time()
        while counter + 15 > start:
            switch_yellow = start + 7
            switch_green = switch_yellow + 2
            switch_red = switch_green + 5
            if time.time() < switch_yellow and self.__color != "красный":
                self.__color = "красный"
                print("красный")
            elif switch_yellow <= time.time() < switch_green and self.__color != "желтый":
                self.__color = "желтый"
                print("желтый")
            elif switch_green <= time.time() < switch_red and self.__color != "зеленый":
                self.__color = "зеленый"
                print("зеленый")
            elif time.time() >= switch_red:
                start = time.time()


a = TrafficLight()
a.running()
print(time.time())
