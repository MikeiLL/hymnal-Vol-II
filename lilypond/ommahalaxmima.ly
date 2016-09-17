\version "2.19.45"
\paper {
	line-width = 4.6\in
}

#(define (parenthesis-ignatzek-chord-names in-pitches bass inversion context) 
(markup #:line ("(" (ignatzek-chord-names in-pitches bass inversion context) ")"))) 

melody = \relative c'' {
  \clef treble
  \key f \major
  \time 6/8 
	\new Voice = "words" {
		\voiceOne 
		\repeat volta 2 {
			a2 a8 a~ | a4 a c8 bes~ |
			bes4 a4 g8 a~ | a4 r2 |
			bes4. a4 a8~ | a4. g4 g8~ |
			g4 a bes8 a~ | a4 r2 |
			f4. f | f a |
			g4 f e8 f~ | f4 r2 |
		}
	}
}

harmony = \relative c' {
  \voiceTwo
	
}

text =  \lyricmode {
	Om Ma -- ha -- la -- kshmyai cha vid -- ma -- he 
	Vi -- shnu pat -- nyai cha dhi -- ma -- hi 
	Tan -- no La -- kshmihi pra -- cho -- da -- yat
}

harmonies = \chordmode {
  	f2. |f2. | bes2. | f2. |
  	bes2. | bes2. | bes2. | f2. |
  	f2. | f2. | c2. | f2. |
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