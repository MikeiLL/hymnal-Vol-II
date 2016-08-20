\version "2.19.45"
\paper {
	line-width = 4.6\in
}

melody = \relative c'' {
  \clef treble
  \key c \minor
  \time 4/4
  \set Score.voltaSpannerDuration = #(ly:make-moment 4/4)
	\new Voice = "words" {
			\partial 4 g4 |
			\repeat volta 2 {
				c4.( bes8 c bes) g( f) | g2. g4 |
				c4.( bes8 c bes) g( f) | g2. g4 |
				c4.( bes8) c r g4 | f4. ees8 f r c4 |
				f4.( ees8 f ees) c( bes) | c2. g'4
				
			}
		}
}

text =  \lyricmode {
	Shan -- |
	gó__ Shan -- gó Shan -- |
	gó__ Shan -- gó A -- | wa__ ki  ọ -- |
	ba te mi Shan -- | gó__ Shan -- gó__ Shan -- |
}

\score {
  <<
    \new ChordNames {
      \set chordChanges = ##t
    }
    \new Staff \with { \magnifyStaff #5/7 } {
    	\new Voice = "one" { \melody }
  	}
    \new Lyrics \lyricsto "words" \text
  >>
  \layout { 
   % #(layout-set-staff-size 14)
   }
  \midi { 
  	\tempo 4 = 125
  }
}