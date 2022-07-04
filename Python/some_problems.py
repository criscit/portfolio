"""
Спортсмен занимается ежедневными пробежками. В первый день его результат составил a километров.
Каждый день спортсмен увеличивал результат на 10 % относительно предыдущего.
Требуется определить номер дня, на который результат спортсмена составит не менее b километров.
Программа должна принимать значения параметров a и b и выводить одно натуральное число — номер дня.
Например: a = 2, b = 3.
Ответ: на 6-й день спортсмен достиг результата — не менее 3 км.
"""
start = int(input('Введите результат в первый день: '))
goal = int(input('Введите целевое значение: '))
day_result = start
day_counter = 1
while day_result < goal:
    day_counter += 1
    day_result *= 1.1
else:
    print(f'Ответ: на {day_counter}-й день спортсмен достиг результата — не менее {goal} км.')
"""
Запросите у пользователя значения выручки и издержек фирмы. Определите, с каким финансовым результатом работает фирма
(прибыль — выручка больше издержек, или убыток — издержки больше выручки). Выведите соответствующее сообщение.
Если фирма отработала с прибылью, вычислите рентабельность выручки (соотношение прибыли к выручке).
Далее запросите численность сотрудников фирмы и определите прибыль фирмы в расчете на одного сотрудника.
"""
revenue = int(input('Введите сумму выручки: '))
costs = int(input('Введите сумму издержек: '))
profit = revenue - costs
if profit > 0:
    print(f'Прибыль {profit}')
    profitability = profit / revenue * 100
    print(f'Рентабельность выручки {profitability}%')
    workers_count = int(input('Введите численность сотрудников: '))
    print('Прибыль фирмы в расчете на одного сотрудника: ', profit / workers_count)
else:
    print(f'Убыток{profit}')
"""
Пользователь вводит целое положительное число. Найдите самую большую цифру в числе.
Для решения используйте цикл while и арифметические операции.
"""
user_input = input('Введите число: ')
if not user_input.isdigit():
    print('Неверный формат числа')
    exit()
max_num = 0
number = int(user_input)
while number and max_num != 9:
    current = number % 10
    number //= 10
    max_num = current if current > max_num else max_num
print('Самая большая цифра в числе: ', max_num)
"""
Узнайте у пользователя число n. Найдите сумму чисел n + nn + nnn.
Например, пользователь ввёл число 3. Считаем 3 + 33 + 333 = 369.
"""
user_input = input('Введите число: ')
if not user_input.isdigit():
    print('Неверный формат числа')
    exit()
characters_count = 0
user_number = int(user_input)
temp_number = user_number
while temp_number:
    temp_number //= 10
    characters_count += 1
first_level_multiplication = 10 ** characters_count + 1
second_level_multiplication = 10 ** (characters_count * 2) + first_level_multiplication
result = user_number + user_number * first_level_multiplication + user_number * second_level_multiplication
print(result)
"""
Пользователь вводит время в секундах. Переведите время в часы, минуты и секунды и выведите в формате чч:мм:сс.
Используйте форматирование строк.
"""
secs = input('Введите количество секунд: ')
if not secs.isdigit():
    print('Неверный формат числа')
    exit()
secs = int(secs)
hours, minutes, seconds = secs // 60 ** 2, (secs % 60 ** 2) // 60, secs % 60
print(f'{hours:>02}:{minutes:>02}:{seconds:>02}')