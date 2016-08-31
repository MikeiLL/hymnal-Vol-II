\version "2.19.45"
\paper {
	line-width = 4.6\in
}

melody = \relative c'' {
  \clef treble
  \key c \major
  \time 3/4
  \set Score.voltaSpannerDuration = #(ly:make-moment 4/4)
	\new Voice = "words" {
		\repeat volta 2 {
		 <b e>2. | <a e'>| <g e'>| <a d> |
		 <e c'> | <a d> | 
		 <<
      {
        \voiceOne
        g2.  
      }
      \new Voice {
        \voiceTwo
        c8( b8)~ b2
      }
    >>
    \oneVoice| <g b>4 r2 |
		}
	}
}

countermelodies = \relative c'' {
  \clef bass
  \key g \major
  \time 3/4
  \set Score.voltaSpannerDuration = #(ly:make-moment 4/4)
	\new Voice = "words" {
		\repeat volta 2 {
		 e,,2. | f8( e)~ e2 | f8( e)~ e2 | e4 r2
		 b8( e)~ e2 | f8( e)~ e2 | d8( e)~ e2 | e4 r2
		}
	}
}

text =  \lyricmode {
	Ra Ma Da Sa
	Sa Say So__ Hung
}

harmonies = \chordmode {
\set noChordSymbol = "" 
 e2.:m | e:m | e:m | e:m |
 a:m | a:m | g | a:7 |
}

\score {
  <<
    \new ChordNames {
      \set chordChanges = ##t
      \harmonies
    }
    \new PianoStaff <<
    \new Staff = "voice" \melody
    \new Lyrics \lyricsto "words" \text
    \new Staff = "countermelodies" \countermelodies
  	>>
  >>
  \layout { 
   % #(layout-set-staff-size 14)
   \context { \ChordNames
     \override ChordName #'font-size = #1
  	} 
  }
  \midi { 
  	\tempo 4 = 116
  }
}