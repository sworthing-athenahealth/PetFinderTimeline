# PetFinderTimeline
Meet Little Smalls, one of my partner & I's foster kitties :) Build on a 5s for the best tab bar experience, but everything else scales just fine to larger / smaller devices.

# Adding Items
Jump in at TimelineManager (conveniently at the top level of the repo), and right under "let eigthEntry...", declare a new entry constant and add it to the array just below.

# Cool Stuff
- Timeline. Circles moving over a line is entirely indistinguishable from a programmatically created bezier path in the "-o-" shape, and your eye even thinks the line is moving! Optical illusion magic + simpler implementation. Drawback? less reusable, in case you need the components later or want to add hiccups to the line.
- Attributed String Replacement. Using attributed string replacement, the line spacing of the description text is set in the storyboard and maintained when the text is set programmatically.
- Dynamic everything. Not a single bit of the layout cares how much text you put in it, so cells size as they should.
- Storyboard-first implementation. Contentious, but primarily done for a demonstration of just how fast one can make something of this fidelity. Suites my skillset more, but given a larger view of the application I'd likely want to make these components more reusable.

# Known Issues
- Font. ProximaNova is changed to the system font, maintaining size and line spacing. Solution: purchasing ProximaNova.
- Floating Headers. Technically a feature, but lbr they look wonky. Solution: use rows for headers. This provides a bit more fine-grained control over grouping, but is not super ideal. Changing the style to Grouped also works, but gives you all sorts of other spacing problems. I'd probably change it to Grouped and just deal with the spacing.
- Timeline Centering. The line is 0.5pt off from the buttons. Mostly unchanged to perserve the all-storyboard implementation. Solution: easily tweaked by programmatically editing the constraint after the fact.
- Exported Gaussian Blur. Exporting the blurred header from the PSD didn't quite maintain the same blur. I think there's a greying I'm missing as well (possibly the transparent overlay is being blurred?). I tweaked the numbers to make it look a bit closer, actually setting it to the black - 80% was not the right visual. Solution: Programmatic blur of the profile picture.
- Spacing on section headers. A remarkably tricky thing to solve, I haven't found anything I'm happy with. It's a pretty classic problem - since you're not *actually* spacing everything, and everything is being defined as discrete units, there isn't a way to divide the empty space such that your top header is the right size as all of the others. Solution(s): One could adjust the content inset of the table, and then remove it when scrolled; one could programmatically determine the height of header views. Both are a bit hacky, the second is particularly displeasing when everything else is sized dynamically.
- Height of the top. Weirdly enough, I think there's just a secret 2px at the top of the PSD missing. The height of the status bar there is a little off, and when you scale the simulator to match you get overhang in one direction or the other.
- Padding around the content. It just doesn't look quite right. I fiddled with it quite a lot, but I suspect the font difference is causing most of it.
