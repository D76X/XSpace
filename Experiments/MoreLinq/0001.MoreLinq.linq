<Query Kind="Expression">
  <Reference Relative="Binaries\MoreLinq.Net4.5.dll">C:\Users\pb00270\Source\Repos\Study-Notes-AZ\MoreLinq\Binaries\MoreLinq.Net4.5.dll</Reference>
</Query>

// MoreLINQ
// https://github.com/morelinq/MoreLINQ
// https://markheath.net/post/exploring-morelinq-1-zipping

// Query Optimization.

// PLINQ
// https://docs.microsoft.com/en-us/dotnet/standard/parallel-programming/parallel-linq-plinq

// LinqOptimizer
// https://github.com/nessos/LinqOptimizer

//--------------------------------------------------------------------------------------------

// How to see the properties of a *.linq
// To see the properties of a LINQPad query right-click and select References and Properties.

// 

//--------------------------------------------------------------------------------------------
// From the drop-down above it is possible to set LINQPad to run *.linq to any of the following

// C# Expression
// Runs expression

// C# Statements
// Runs expression

// C# Program
// It's like you are in the body of the classic static class Program of a console app

//--------------------------------------------------------------------------------------------

// STATEMENTS and EXPRESSIONS

// Refs
// https://fsharpforfunandprofit.com/posts/expressions-vs-statements/
// https://www.quora.com/Whats-the-difference-between-a-statement-and-an-expression-in-Python-Why-is-print-%E2%80%98hi%E2%80%99-a-statement-while-other-functions-are-expressions
// https://stackoverflow.com/questions/4728073/what-is-the-difference-between-an-expression-and-a-statement-in-python

//--------------------------------------------------------------------------------------------

// EXPRESSIONS
// An expression when evaluated amounts to a value that is the result of teh expression.

// Select C# Expression
// In this mode LINQPad execute the expressions.
// Notice that you do not need a semicolumn at the end of any of any expressions.
// Expressions are statements as well.
// Expressions are parts of statements.
// Expressions can also include function calls.
// Expressions produce at least one value.
// One way to think of this is that the purpose of an expression is to create a value (with some possible side-effects)
(new DateTime(DateTime.Today.Year, 12, 25) - DateTime.Today).TotalDays

// Examples of Expressions
//3 + 5
//map(lambda x: x*x, range(10))
//[a.x for a in some_iterable]
//yield 7

//--------------------------------------------------------------------------------------------

// STATEMENTS
// A statement produces some side effects that is changes the state of an object in memory.
// Anything that can make up a line of  code.

// A statement does something and are often composed of expressions or other statements.
// A statement is just a standalone unit of execution and doesn’t return anything. 
// The sole purpose of a statement is to have side-effects.
// A truly pure functional language cannot support statements at all!
// In F# everything is an expression! That is everything produces a value.
// First, unlike statements, smaller expressions can be combined (or “composed”) into larger expressions. So if everything is an expression, then everything is also composable.
// Second, a series of statements always implies a specific order of evaluation, which means that a statement cannot be understood without looking at prior statements. But with pure expressions, the subexpressions do not have any implied order of execution or dependencies.

//--------------------------------------------------------------------------------------------