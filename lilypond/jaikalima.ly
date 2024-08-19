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
			b4 b8 b4. c4 | b4 b8 b4. c4 |
			b4 b8 b4. c4 | b r fis'2 |
			b,4 b8 b4. c4 | b r fis'2 |
			b,4 b8 b4. c8 dis8~ | dis4 dis8 e fis2 |
		}
	}
}

harmony = \relative c' {
  \voiceTwo
	
}

text =  \lyricmode {
	Jai Kā -- lī Ma
	Jai Kā -- lī Ma
	Jai Kā -- lī Ma
	Jai Om
	Jai Kā -- lī Ma
	Jai Om
	Jai Kā -- lī -- Kā -- yai Na -- ma -- ḥ
}

harmonies = \chordmode {
  	b2. a4:m | b2. a4:m |
  	b2. a4:m | b2. a4:m |
  	b2. a4:m | b2. a4:m |
  	b2. a4:m | b2. a4:m |
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