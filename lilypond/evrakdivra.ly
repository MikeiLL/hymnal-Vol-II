\version "2.19.45"
\paper {
	line-width = 4.6\in
}

melody = \relative c'' {
  \clef treble
  \key fis \major
  \time 4/4
  \new Voice = "words" {
		\repeat volta 2 {
			gis4 gis8 gis ais4 ais | cis1 |
			dis4 dis8 dis cis4 cis | cis ais2. |
			r2 bis4 bis8 bis | cis4 cis2. |
			r2 bis4 bis8 bis | cis4 cis2. |
		}
	}
}

text =  \lyricmode {
	Ev -- ra k’ -- di -- vra paz
	Ev -- ra k’ -- di -- vra cal -- ma
	Ev -- ra k’ -- di -- vra__
	Ev -- ra k’ -- di -- vra__
}

\score {
      <<
    \new Staff  {
    	\new Voice = "one" { \melody }
  	}
    \new Lyrics \lyricsto "words" \text
  >>
  \layout { 
   #(layout-set-staff-size 16)
   }
    \midi { 
  	\tempo 4 = 125
  }
}