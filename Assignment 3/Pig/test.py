file1 = open('yago_test.tsv', 'r')
file2 = open('nf.tsv', 'w')
Lines = file1.readlines()

for line in Lines:
    x = line.split()
    file2.write('\t'.join(x) + "\n")
