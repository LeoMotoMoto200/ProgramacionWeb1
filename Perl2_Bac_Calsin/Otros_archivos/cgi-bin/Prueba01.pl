#!/usr/bin/perl -w
use strict;
use warnings;
use CGI;

# Crear un objeto CGI
my $cgi = CGI->new;

# Iniciar la cabecera HTML
print $cgi->header('text/html; charset=UTF-8');
print "<!DOCTYPE html>\n";
print "<html lang='es'>\n";
print "<head>\n";
print "<style>\n";

# Aquí va el CSS 
print "body {\n";
print "    font-family: 'Helvetica Neue', Arial, sans-serif;\n";
print "    background: linear-gradient(135deg, #0072ff, #00c6ff);\n";
print "    background-size: cover;\n";
print "    background-position: center;\n";
print "    color: #333;\n";
print "    margin: 0;\n";
print "    padding: 0;\n";
print "    display: flex;\n";
print "    justify-content: center;\n";
print "    align-items: center;\n";
print "    height: 100vh;\n";
print "    flex-direction: column;\n";  # Añadido para apilar elementos verticalmente
print "}\n";

print "h1 {\n";
print "    color:  #ffffff;\n";
print "    margin-bottom: 20px;\n";
print "    font-size: 2.8em;\n";
print "    font-weight: 700;\n";
print "    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);\n";
print "    text-align: center;\n";  # Asegurar que el título está centrado
print "}\n";

print "form {\n";
print "    padding: 40px;\n";
print "    border-radius: 15px;\n";
print "    background-color: white;\n";
print "    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);\n";
print "    width: 400px;\n";
print "    text-align: left;\n";
print "    display: flex;\n";  # Flexbox para centrar el formulario internamente
print "    flex-direction: column;\n";  # Alinear los elementos del formulario verticalmente
print "    justify-content: center;\n";  # Centrar contenido verticalmente
print "}\n";

print "label {\n";
print "    font-size: 1.2em;\n";
print "    font-weight: bold;\n";
print "    margin-bottom: 10px;\n";
print "    display: block;\n";
print "    color: #333;\n";
print "}\n";

print "input[type='text'] {\n";
print "    padding: 12px;\n";
print "    width: calc(100% - 24px);\n";
print "    border-radius: 8px;\n";
print "    border: 2px solid #ddd;\n";
print "    margin-bottom: 20px;\n";
print "    font-size: 16px;\n";
print "    transition: border 0.3s ease;\n";
print "}\n";

print "input[type='text']:focus {\n";
print "    border-color: #0072ff;\n";
print "    outline: none;\n";
print "    box-shadow: 0 0 8px rgba(0, 114, 255, 0.2);\n";
print "}\n";

print "button {\n";
print "    background-color: #0072ff;\n";
print "    color: white;\n";
print "    border: none;\n";
print "    padding: 12px 30px;\n";
print "    border-radius: 8px;\n";
print "    cursor: pointer;\n";
print "    font-size: 16px;\n";
print "    font-weight: bold;\n";
print "    transition: background-color 0.3s ease;\n";
print "    width: 100%;\n";
print "}\n";

print "button:hover {\n";
print "    background-color: #0056cc;\n";
print "}\n";

print "p {\n";
print "    font-size: 1.2em;\n";
print "    margin-top: 15px;\n";
print "    color: #333;\n";
print "}\n";

print ".error {\n";
print "    color: #ff4a4a;\n";
print "    font-weight: bold;\n";
print "    text-align: center;\n";
print "}\n";

print "</style>\n";
print "<meta charset='UTF-8'>\n";
print "<meta name='viewport' content='width=device-width, initial-scale=1.0'>\n";
print "<title>Calculadora CGI</title>\n";
print "</head>\n";
print "<body>\n";
print "<h1>Calculadora CGI</h1>\n";

# Obtener la operación desde el formulario
my $operacion = $cgi->param('operacion') || '';

# Eliminar espacios en blanco
$operacion =~ s/\s+//g;

# Función para resolver operaciones sin paréntesis
sub resolver_sin_parentesis {
    my ($op) = @_;

    # Resolver multiplicación y división primero
    while ($op =~ /(\d+\.?\d*)\s*([\*\/])\s*(\d+\.?\d*)/) {
        my $a = $1;
        my $op_sign = $2;
        my $b = $3;
        my $resultado;

        if ($op_sign eq '*') {
            $resultado = $a * $b;
        } elsif ($op_sign eq '/') {
            if ($b == 0) {
                die "Error: División por cero.\n";
            }
            $resultado = $a / $b;
        }

        $op =~ s/\Q$a$op_sign$b\E/$resultado/;
    }

    # Resolver suma y resta
    while ($op =~ /(\d+\.?\d*)\s*([\+\-])\s*(\d+\.?\d*)/) {
        my $a = $1;
        my $op_sign = $2;
        my $b = $3;
        my $resultado;

        if ($op_sign eq '+') {
            $resultado = $a + $b;
        } elsif ($op_sign eq '-') {
            $resultado = $a - $b;
        }

        $op =~ s/\Q$a$op_sign$b\E/$resultado/;
    }

    return $op;
}

# Función para resolver operaciones con paréntesis
sub resolver_con_parentesis {
    my ($op) = @_;

    # Resolver paréntesis primero
    while ($op =~ /\(([^()]+)\)/) {
        my $sub_op = $1;
        my $resultado = resolver_sin_parentesis($sub_op);
        $op =~ s/\(\Q$sub_op\E\)/$resultado/;
    }

    return resolver_sin_parentesis($op);
}

# Solo procesar si se ingresó una operación
if ($operacion) {
    eval {
        my $resultado_final = resolver_con_parentesis($operacion);
        print "<p>El resultado de la operación '$operacion' es: $resultado_final</p>\n";
    };
    if ($@) {
        print "<p class='error'>Error en la operación: $@</p>\n";
    }
} else {
    print "<p>Por favor, ingresa una operación en el formulario.</p>\n";
}

# Formulario para ingresar la operación
print "<form action='/cgi-bin/Prueba01.pl' method='POST'>\n";
print "    <label for='operacion'>Ingresa la operación:</label>\n";
print "    <input type='text' id='operacion' name='operacion'>\n";
print "    <button type='submit'>Calcular</button>\n";
print "</form>\n";

# Cierre del HTML
print "</body>\n";
print "</html>\n";


