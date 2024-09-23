# Learning to Play Vim - the Book Companion

This is the book companion for [Learning to Play Vim](https://themouseless.dev/vim). I'd recommend you to download it and use it to follow along while reading the book.

## How to Download the Book Companion

You can either:

* Click on the blue "<> Code" button on this page, and then click on "Download ZIP". When it's downloaded, just unzip it with your favorite application which can... unzip things.

* If you have Git installed, run the following in your terminal, in the directory where you want to download the book companion:
  ```
  git clone https://github.com/Phantas0s/learning_to_play_vim_companion
  ```

## What's in There?

There are a couple of things in there:

1. Each rank folder (`rank_01` to `rank_16`) has the Vim configuration (the "vimrc") for the rank in question. We add new elements to this configuration at almost every rank.
   The configuration for Neovim is in "nvim" (both Vimscript vimrc "init.vim" and Lua vimrc "init.lua" are given, but you should only use one of them for your own configuration).
   The configuration for Vim is in ".vim".

2. Most solutions to the exercises are in the book, but, as the book progress, the solution involves more and more complex functions which are more and more difficult to copy or even read. That's why these functions are also in the folder "solution" in the book companion.

3. The Go project "gocket", a small personal project we'll use in some ranks, as well as in many exercises.

4. The file "functions.lua" we'll use again, and again, and again, throughout the book.

5. Each rank folder can also contains some files we use in the rank itself.

