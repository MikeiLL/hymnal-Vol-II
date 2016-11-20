\version "2.19.45"
\paper {
	line-width = 4.6\in
}

melody = \relative c' {
  \clef treble
  \key ees \major
  \time 4/4
  \set Score.voltaSpannerDuration = #(ly:make-moment 4/4)
	\new Voice = "words" {
		\partial 2 bes4 c
		\repeat volta 2 {
			d2 d~ | d c4 d | ees2 ees( | d4 c) bes c |
			d2 ees4 ees | ees2 ees4 d | ees1 | r2 ees4 d |
			c2 d4 c | \time 2/4 bes2 | \time 4/4 c4 d ees f |
			ees( f8 ees) d c | c1~ | c2 bes4 c |  
		}
  }
}

text =  \lyricmode {
	\set associatedVoice = "words"
	Na -- mo Dev -- yea Ma -- ha Dev -- yea__ Shi -- va -- yea
	Sa -- ta -- tam Na -- ma -- ha.
	Pra -- krit -- yea Bha -- dra -- yea
	Ni -- ya -- ta Pra -- na__ -- ha Sma -- tam__. Na -- mo
}

harmonies = \chordmode {
\set noChordSymbol = "" 
	aes |
}

\score {
  <<
    \new ChordNames {
      \set chordChanges = ##t
      \harmonies
    }
    \new Staff {
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