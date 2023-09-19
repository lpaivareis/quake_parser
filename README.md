# Quake Parser
This project aims to read a log file of the game Quake 3 Arena and extract information about the matches.

## Description

It is a very simple project that uses only the Ruby language and a few other libraries:
  - Rubocop e Rubocop-performance: Used to check code quality and maintain a good writing standard.
  - Byebug: Used to debug the code.
  - Awesome Print: Used to improve the visualization of some arrays and hashes.

## Requirements

To run the project, you must have installed Ruby installed on your machine, if you do not recommend using ASDF to install Ruby.
I recommend using Ruby version 3.2 or higher.

If you have not installed I recommend following the tutorial below (If you remember to change the command to install version 3.2 or higher):
  - [Installing Ruby with ASDF](https://www.lucascaton.com/pt-BR/2020/02/17/instalacao-do-ruby-do-nodejs-no-ubuntu-linux-usando-asdf/)

Caso esteja utilizando MacOs:
  - [Installing Ruby with ASDF in MacOs](https://www.lucascaton.com.br/2020/02/17/instalacao-do-ruby-do-nodejs-no-macos-usando-asdf/)

## Running the project

To use the project, simply clone the repository and run the quake_parser.rb file.

```sh
  ruby src/quake_parser.rb
```

## Rubocop

To check the quality of the code, just run the command below:

```sh
  rubocop
```
