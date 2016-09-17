\version "2.19.45"
\paper {
	line-width = 4.6\in
}

#(define (parenthesis-ignatzek-chord-names in-pitches bass inversion context) 
(markup #:line ("(" (ignatzek-chord-names in-pitches bass inversion context) ")"))) 

melody = \relative c' {
  \clef treble
  \key g \major
  \time 4/4 
	\new Voice = "words" {
		\voiceOne 
		\repeat volta 2 {
			e4 r e r | e e8 e4 r4. |
			e4 e e8 e e e | e e e4 e e |
			dis2( c) | r1 |
			c4 r a r | c4 r a r |
			c4 r a r |
			c d e fis | g2 a4 r |
			a a b b | c2 d4 r |
			e r c r | b r a r |
			g r b r | a r fis r |
		}
	}
}

harmony = \relative c' {
  \voiceTwo
	
}

text =  \lyricmode {
	Root lock born to rock
	Coiled up serpent and a mental road block it's
	On__
	Sat Nam Sat Nam Sat Nam
	Ku -- la -- kun -- da -- li -- ni Ku -- la -- kun -- da -- li -- ni
	Sat Nam Sat Nam Sat Nam Sat Nam
}

harmonies = \chordmode {
  	e:m1 | e:m1 | e:m1 | e:m1 |
  	a:m1 | a:m1 |
  	a:m1 | a:m1 | a:m1 |
  	a:m1 | a:m1 | a:m1 | a:m1 |
  	a:m1 | a:m1 | a:m1 | a:m1 |
}

\score {
  <<
    \new ChordNames {
      \set chordChanges = ##t
      \harmonies
    }
    \new Staff  {
    <<
    	\new Voice = "upper" { \melody }
    	\new Voice = "lower" { \harmony }
    >>
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