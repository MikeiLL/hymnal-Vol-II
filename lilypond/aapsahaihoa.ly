\version "2.19.45"
\paper {
	line-width = 4.6\in
}

melody = \relative c'' {
  \clef treble
  \key f \major
  \time 4/4
  \set Score.voltaSpannerDuration = #(ly:make-moment 4/4)
	\new Voice = "words" {
		\repeat volta 2 {
		 c4 r8 c c4 c | c bes bes bes |
		 c r c c | c bes bes r |
		 bes r bes r |
		}
	}
}

text =  \lyricmode {
	Aap Sa -- ha -- i Ho -- a Sa -- chay 
	Daa Sa -- chaa Do -- a, Har Har Har
}

harmonies = \chordmode {
\set noChordSymbol = "" 
 c1 | bes:m | c1 | bes:m | bes:m
}

\score {
  <<
    \new ChordNames {
      \set chordChanges = ##t
      \harmonies
    }
    \new Staff  {
    	\new Voice = "one" { \melody }
  	}
    	\new Lyrics \lyricsto "words" \text
  >>
  \layout { 
   #(layout-set-staff-size 16)
   \context { \ChordNames
     \override ChordName #'font-size = #1
  	} 
  }
  \midi { 
  	\tempo 4 = 116
  }
}