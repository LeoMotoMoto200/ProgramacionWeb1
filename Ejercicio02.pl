#!/usr/bin/perl
use strict;
use warnings;
use List::Util qw(max min sum);

# Solicitar la cantidad de notas al usuario
print "Ingrese una cantidad 'n' de notas: ";
my $cantNotas = <STDIN>;
chomp($cantNotas);

# Arreglo para almacenar las notas
my @notas;

# Bucle para ingresar las notas
for (my $i = 1; $i <= $cantNotas; $i++) {
    print "Ingrese la nota $i: ";
    my $nota = <STDIN>;
    chomp($nota);
    push @notas, $nota;
}

# Encontrar la peor y mejor nota
my $peor = min(@notas);
my $mejor = max(@notas);

# Eliminar la peor nota y duplicar la mejor nota
@notas = grep { $_ != $peor } @notas;  # Eliminar la peor nota
push @notas, $mejor;                    # Duplicar la mejor nota

# Calcular el promedio
my $promedio = sum(@notas) / scalar(@notas);

# Imprimir el resultado
print "El promedio ajustado es: $promedio\n";
