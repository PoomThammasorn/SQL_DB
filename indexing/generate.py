import random

d = dict()
prod = ['P001', 'P002', 'P003', 'P004', 'P005',
        'P006', 'P007', 'P008', 'P009', 'P010']

size = 0

for p in prod:
    amount_of_location = random.randint(7000, 10000)
    location_list = list()
    for j in range(amount_of_location):
        act = random.randint(0, 10)
        for k in range(act):
            l = list()
            l.append('location' + str(j+1))
            l.append('activity_type' + str(k+1))
            location_list.append(l)
            size += 1
    d[p] = location_list


with open('activity_filter.sql', 'w') as file:
    pass  # An empty block will effectively clear the file

file = open('activity_filter.sql', 'w')
file.write('DELETE FROM activity_filter\n')
file.write("WHERE location LIKE 'location%';\n\n")
file.write('-- data size: ' + str(size) + ' --\n')
file.write('INSERT INTO activity_filter VALUES\n')
for provider, entries in d.items():
    front = "('" + provider + "', "
    for index, e in enumerate(entries):
        location = "'" + e[0] + "'"
        activity = "'" + e[1] + "'"

        # Check if it is the last element in the loop
        if index == len(entries) - 1 and provider == 'P010':
            text = front + location + ", " + activity + ");" + '\n'
        else:
            text = front + location + ", " + activity + ")," + '\n'
        file.write(text)
file.close()
