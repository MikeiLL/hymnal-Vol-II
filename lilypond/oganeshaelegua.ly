\version "2.19.45"
\paper {
	line-width = 4.6\in
}

melody = \relative c' {
	\override Staff.TimeSignature #'stencil = ##f 
  \clef treble
  \time 12/8
  \key c \major
  \set Score.voltaSpannerDuration = #(ly:make-moment 4/4)
	\new Voice = "words" {
		\repeat volta 2 {
			 r4 f8  f f f f4 d8 d4. |
			 r4 e4. e8 e4. c4. | r4 d4. d8 d4. b4. | c4. d4. e2. |
			 r4 f4. f8 f4. d4. | 
			 r4 e4. e8 e4. c4. | r4 d4. d8 d4. b4. | c4. d4. e2. |
			}
		\repeat volta 2 {
		 	c8 c c c c4 d8 d4 e8( d) e | c1. |
		 }
		\repeat volta 2 {
		 	c8 c c c c4 d8 d4 f8( d) f | 
		 	<<
      {
        \voiceOne
        c1. |
      }
       \new Voice = "responseMelody" {
         \voiceTwo
        r2 f'8 d f d f4 d |
      }
    >>
		 }
    \partial 4. aes4 aes8~ |
		\repeat volta 2 {
		 	<<
      {
        \voiceOne
        aes1.~ | aes1 r8 aes4 aes8
      }
       \new Voice = "responseMelody2" {
         \voiceTwo
        r1 r8 aes4 aes8~ | aes1.
      }
    >>
		 }
		\partial 4. c8( aes) c |
		\repeat volta 2 {
		 	<<
      {
        \voiceOne
        aes1.~ | aes1 r8 c( aes) c
      }
       \new Voice {
         \voiceTwo
        r1 r8 c( aes) c | aes1.~ 
      }
    >>
		 }
	}
}

text =  \lyricmode {
	There's got -- ta be some -- thing real
	Let me find it
	Om Ga -- ṇe -- śa, E -- le -- ggua
	O -- pen wide these gates of no -- where
	Om Ga -- ṇe -- śa, E -- le -- ggua.
	I -- ba O -- ri -- ṣa I -- ba La -- ye O 
	I -- ba O -- ri -- ṣa I -- ba La -- ye O 
	A -- ṣe__ A -- ṣe
	A -- ṣe- -- o!  A -- ṣe- -- o!
}

response = \lyricmode {
	<<
 {
 \set stanza = #"" 
   Y’ -- a -- go E -- le -- gba
   A -- ṣe
  }
 \new Lyrics {
   \set associatedVoice = "melody"
   \set stanza = #""
   Y’ -- a -- go E -- gun -- gun
  }
  \new Lyrics {
   \set associatedVoice = "melody"
   \set stanza = #""
   A -- ṣe- -- o!  A -- ṣe- -- o!
  }
>>
}



% Egungun Ancestors
% Y'ago == "yield". Please hear me, Allow this prayer to enter.
% http://oshoosi.com/ancestor-ritual.html
% Aṣe-o So be it!
harmonies = \chordmode {
	f:m6
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
    	\new Lyrics \lyricsto "responseMelody" \response
    	
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