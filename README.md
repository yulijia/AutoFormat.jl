AutoFormat.jl
======

[![Build Status](https://travis-ci.org/yulijia/AutoFormat.jl.png)](https://travis-ci.org/yulijia/AutoFormat.jl)

Basic autoformat tool for Julialang

# Notice
As Stefan mentioned **the right way to do this is to enhance the printing of Julia ASTs to the point where the printed form of an expression object is the properly formatted version.**

Read list:
- http://llvm.org/devmtg/2013-04/
- http://blog.leahhanson.us/julia-introspects.html
- https://github.com/yulijia/julia-prettyshow
- https://github.com/yulijia/julia/blob/master/base/methodshow.jl
- https://github.com/yulijia/julia/blob/master/base/show.jl

# Installing Unregistered Packages

	 Pkg.clone("git://github.com/yulijia/AutoFormat.jl.git")

# Example

	using AutoFormat_with_regular
	format("/home/yu/messy_code.jl","/home/yu/messy_code_format.jl",2)
        # usage : format_demo(input_file,output_file,tab_width)
        # download a messy code file example at https://gist.github.com/yulijia/9391666

# Todo
* Learning abstract syntax tree
* Fix bugs
  - can not format one line block
  - matrix alignment
  - wrong comments style
* Other features
  - indent with tabs
  - print result with STDOUT
  - print comments or not
  - display diffs instead of rewriting files
