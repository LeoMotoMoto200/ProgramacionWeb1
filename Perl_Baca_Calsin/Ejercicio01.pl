#!/usr/bin/perl
use strict;
use warnings;

 my $usuario;
 my $dominio;

  print "Ingrese su nombre de usuario\n";
    $usuario = <STDIN>;
    chomp($usuario);
  print "Ingrese el dominio\n";
    $dominio = <STDIN>;
    chomp($dominio);

  print "\n$usuario\@$dominio";

