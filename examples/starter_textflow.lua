local pdflib = require 'pdflib'

local tf = -1
local result
local llx1, lly1, urx1, ury1 = 50, 50, 250, 800
local llx2, lly2, urx2, ury2 = 300, 50, 500, 800

-- Repeat the dummy text to produce more contents
local count = 50

local optlist1 =
    "fontname=Helvetica fontsize=10.5 encoding=winansi " ..
    "fillcolor={gray 0} alignment=justify"

local optlist2 =
    "fontname=Helvetica-Bold fontsize=14 encoding=winansi " ..
    "fillcolor={rgb 1 0 0} charref"

--[[
Dummy text for filling the columns. Soft hyphens are marked with
the character reference "&shy;" (character references are
enabled by the charref option).
--]]
local text =
    "Lorem ipsum dolor sit amet, consectetur adi&shy;pi&shy;sicing elit, " ..
    "sed do eius&shy;mod tempor incidi&shy;dunt ut labore et dolore magna " ..
    "ali&shy;qua. Ut enim ad minim ve&shy;niam, quis nostrud exer&shy;citation " ..
    "ull&shy;amco la&shy;bo&shy;ris nisi ut ali&shy;quip ex ea commodo " ..
    "con&shy;sequat. " ..
    "Duis aute irure dolor in repre&shy;henderit in voluptate velit esse cillum " ..
    "dolore " ..
    "eu fugiat nulla pari&shy;atur. Excep&shy;teur sint occae&shy;cat " ..
    "cupi&shy;datat " ..
    "non proident, sunt in culpa qui officia dese&shy;runt mollit anim id est " ..
    "laborum. "

-- create a new PDFlib object
local p = pdflib.new()
if not p.handle then
    print( "Couldn't create PDFlib object (out of memory)!" )
    os.exit( 2 )
end

-- This means we must check return values of load_font() etc.
p:set_option( "errorpolicy=return" )

if p:begin_document("starter_textflow.pdf", 0, "") == -1 then
    print("Error: " .. p:get_errmsg())
    p:delete()
    os.exit( 2 )
end

p:set_info("Creator", "PDFlib starter sample")
p:set_info("Title", "starter_textflow")

--[[ Create some amount of dummy text and feed it to a Textflow
     object with alternating options.
--]]
for i = 1, count do
    local num = i .. ' '
    tf = p:add_textflow(tf, num, 0, optlist2)
    if tf == -1 then
	print("Error: " .. p:get_errmsg())
	p:delete()
	os.exit( 2 )
    end

    tf = p:add_textflow(tf, text, 0, optlist1)
    if tf == -1 then
	print("Error: " ..  p:get_errmsg())
	p:delete()
	os.exit( 2 )
    end
end

--[[ Loop until all of the text is placed; create new pages
     as long as more text needs to be placed. Two columns will
     be created on all pages.
 --]]
while true do
    -- Add "showborder to visualize the fitbox borders
    local optlist = "verticalalign=justify linespreadlimit=120% "

    p:begin_page_ext(0, 0, "width=a4.width height=a4.height")

    -- Fill the first column
    result = p:fit_textflow( tf, llx1, lly1, urx1, ury1, optlist )

    -- Fill the second column if we have more text
    if result ~= '_stop' then
	result = p:fit_textflow( tf, llx2, lly2, urx2, ury2, optlist )
    end

    p:end_page_ext("")

    --[[ "_boxfull" means we must continue because there is more text
	 "_nextpage" is interpreted as "start new column"
     --]]
    if result ~= '_boxfull' and result ~= '_nextpage' then
	break
    end
end

-- Check for errors
if result ~= '_stop' then
    --[[ "_boxempty" happens if the box is very small and doesn't
	 hold any text at all.
     --]]
    if result == '_boxempty' then
	print("Error: Textflow box too small")
	p:delete()
	os.exit( 2 )
    else
	--[[ Any other return value is a user exit caused by
	     the "return" option; this requires dedicated code to
	     deal with.
	 --]]
	print("User return '".. result .. "' found in Textflow" )
	p:delete()
	os.exit( 2 )
    end
end

p:delete_textflow(tf)
p:end_document("")
p:delete()
