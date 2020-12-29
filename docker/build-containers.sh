#!/usr/bin/env bash

for i in {dir,fd,sd,webui};do
  echo -e "Building \e[33;1mbareos-$i\e[0m\n"
  docker build bareos-$i -t bareos-$i
  echo -e "\e[32;1mbareos-$i\e[0m built\n"
done

