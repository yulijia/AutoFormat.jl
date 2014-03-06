AutoFormat.jl
======

[![Build Status](https://travis-ci.org/yulijia/AutoFormat.jl.png)](https://travis-ci.org/yulijia/AutoFormat.jl)

Basic autoformat tool for Julialang


# Installing Unregistered Packages

	 Pkg.clone("git://github.com/yulijia/AutoFormat.jl.git")

# Eample

	using AutoFormat
	format("/home/yu/messy_code.jl","/home/yu/messy_code_format.jl",2)
        # usage : format(input_file,output_file,tab_width)

# Todo
* Collection Julia Coding Style (format Style)
* Fix bugs
  - can not format one line block
  - matrix alignment
  - wrong comments style
* Other features
  - indent with tabs
  - print result with STDOUT
  - print comments or not
  - display diffs instead of rewriting files
