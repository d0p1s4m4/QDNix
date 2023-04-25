const quotes = [
	["UNIX is very simple, it just needs a genius to understand its simplicity.", "Dennis Ritchie"],
	["UNIX was not designed to stop its users from doing stupid things, as that would also stop them from doing clever things.", "Doug Gwyn"],
	["Pretty much everything on the web uses those two things: C and UNIX.", "Dennis Ritchie"]
];

const selected = quotes[Math.floor(Math.random() * quotes.length)];

const quoteElement = document.getElementById("quote-text");
const authorElement = document.getElementById("quote-author");

if (authorElement !== null && quoteElement !== null)
{
	console.log(selected);
	[quoteElement.innerText, authorElement.innerText] = selected;
}
