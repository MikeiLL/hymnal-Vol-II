\version "2.19.45"
\paper {
	line-width = 4.6\in
}

melody = \relative c'' {
  \clef treble
  \key c \major
  \time 4/4
  \set Score.voltaSpannerDuration = #(ly:make-moment 4/4)
	\new Voice = "words" {
			a8 r a r f g g r | f g g f g( a) a r |
			a r a r f g g r | f g g g f( e) d r |
			a' r c r c( bes) bes r | bes bes bes c bes a r |
			a r a r f g g r | f g a f ees( d) d' |
		}
}

text =  \lyricmode {
	Sat chit a -- nan -- da | a -- nan -- da pra -- har__ -- sha |
	Sat chit a -- nan -- da | a -- nan -- da pra -- har__ -- sha |
	Sat chit a -- nan -- da | a -- nan -- da pra -- har__ -- sha |
	Sat chit a -- nan -- da | a -- nan -- da pra -- har__ -- sha |
}


twochords = \chordmode { d2:m g:m | a:7 d:m | }

harmonies = {
	\twochords \twochords
	\twochords \twochords
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
   }
  \midi { 
  	\tempo 4 = 125
  }
}