\version "2.19.45"
\paper {
	line-width = 4.6\in
}

melody = \relative c' {
  \clef treble
  \key d \minor
  \time 6/8
  \set Score.voltaSpannerDuration = #(ly:make-moment 4/4)
    \repeat volta 2 {
    <<
    \new Voice = "words" {
			\partial 4. d4 bes'8 |	
				a4. a | r g4 f8 | a4. a | r f4 a8 |
				g4. g | r g4 f8 | \times 3/2 { a8( bes) a( g} | f4.) d4 bes'8 |	
		}
    \new Voice = "hidden" {
      \hideNotes {
			 \partial 4. d4 bes'8 |	
				a4.~ a | r g4 f8 | a4.~ a | r f4 a8 |
				g4.~ g | r g4 f8 | \times 3/2 { a8( bes a g} | f4.) d4 bes'8 |	
			}
		}
    >>
  }
}

text =  \lyricmode {
	\set associatedVoice = "words"
	I sur -- ren -- der. I sur -- ren -- der.
	I sur -- ren -- der. I sur -- ren__ -- der__. I sur
}

wordsTwo =  \lyricmode {
	\set associatedVoice = "hidden"
	Lax -- mi Ma-
	Lax -- mi Ma-
	Lax -- mi Ma-
	Lax -- mi Ma__- Lax -- mi
}

harmonies = \chordmode {
	\set noChordSymbol = "" 
	r4.| 
	d2.:m | d:m | d:m | d:m |
	a:7 | a:7 | d:m | d:m |
}

\score {
  <<
    \new ChordNames {
      \set chordChang = ##t
      \harmonies
    }
    \new Staff  {
    	\new Voice = "one" { \melody }
  	}
    \new Lyrics \lyricsto "words" \text
    \new Lyrics \lyricsto "hidden" \wordsTwo
  >>
  \layout { 
   #(layout-set-staff-size 16)
   }
  \midi { 
  	\tempo 4 = 125
  }
}