\version "2.19.45"
\paper {
	line-width = 4.6\in
}

#(define (parenthesis-ignatzek-chord-names in-pitches bass inversion context) 
(markup #:line ("(" (ignatzek-chord-names in-pitches bass inversion context) ")"))) 

melody = \relative c'' {
  \clef treble
  \key f \major
  \time 4/4 
	\new Voice = "words" {
		\voiceOne 
		\repeat volta 2 {
			a8 a4. a4 g | a r a( g) | a8 a4. a4 g | g2 g4 r |
			g8 g4. g4 a | g r g( a) | a8 a4. a8 g4. | f2 f4 r |
		}
	}
}

harmony = \relative c'' {
    \voiceTwo
      
}

text =  \lyricmode {
	Wa -- hay gu -- ru Sat -- nam__
	Ha -- re ha -- re Ram Ram
	Wa -- hay gu -- ru Sat -- nam__
	Ha -- re ha -- re Ram Ram
}

harmonies = \chordmode {
  	d1:m | d:m | f | c |
  	a:m | 
  	\set chordNameFunction = #parenthesis-ignatzek-chord-names 
		a1:7 
		\unset chordNameFunction 
  	| bes/f | f |
}

\score {
  <<
    \new ChordNames {
      \set chordChanges = ##t
      \harmonies
    }
    \new Staff \with { \magnifyStaff #5/7 } {
    <<
    	\new Voice = "upper" { \melody }
    	\new Voice = "lower" { \harmony }
    >>
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