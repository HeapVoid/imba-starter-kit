import * as ICONS from 'imba-phosphor-icons/filled'
import {Header} from './_components.imba'
import {GithubIcon, NpmIcon} from './icons.imba'

# -------------------------------------
#  Color Schemes
# -------------------------------------
import {ColorModes, mix, pallete, ColorSchemeSwitcher, ColorModeSwitcherSimple} from 'imba-color-modes'
const cs = new ColorModes!
# const steps = [1,2,3,4,5,6,7,8,9,18,27,36,45,54,63,72,81,90,99]
# cs.shades('base',{l:100, c:0.0383, h:245}, {l:15, c:0.0383, h:245}, steps)
# cs.shades('gray',{l:95, c:0, h:245}, {l:20, c:0, h:245}, steps)
# cs.css-var('accent','#007AFF') # just an example - easier to define in css

# import {pallete, mix} from './colors.imba'

# let color = '#1687ff'
let hue = 211

def theme _hue = 0
	hue += Math.round(60 + Math.random! * 60) if !_hue
		
	let h = hue
	let s = 1
	let l = 0.4

	const k = do(n) (n + h / 30) % 12
	const a = s * Math.min(l, 1 - l)
	const f = do(n)	Math.round(255 * (l - a * Math.max(Math.min(k(n) - 3, 9 - k(n), 1), -1))).toString(16).padStart(2, '0')
	const color = "#{f(0)}{f(8)}{f(4)}"
	document.documentElement.style.setProperty("--accent", color)
		

	pallete 'base', '#FFFFFF', color, mix(color,25,'#000000')
	pallete 'gray', '#FFFFFF', '#a8a8a8', mix(color,25,'#000000') # '#001029'

theme(211)


# tag ThemeRefresh
# 	<self>
# 		<svg fill="#000000" viewBox="0 0 256 256" xmlns="http://www.w3.org/2000/svg">
# 			<path d="M224,48V96a8,8,0,0,1-8,8H168a8,8,0,0,1-5.66-13.66L180.65,72a79.48,79.48,0,0,0-54.72-22.09h-.45A79.52,79.52,0,0,0,69.59,72.71,8,8,0,0,1,58.41,61.27,96,96,0,0,1,192,60.7l18.36-18.36A8,8,0,0,1,224,48ZM186.41,183.29A80,80,0,0,1,75.35,184l18.31-18.31A8,8,0,0,0,88,152H40a8,8,0,0,0-8,8v48a8,8,0,0,0,13.66,5.66L64,195.3a95.42,95.42,0,0,0,66,26.76h.53a95.36,95.36,0,0,0,67.07-27.33,8,8,0,0,0-11.18-11.44Z">


# -------------------------------------
#  Localization
# -------------------------------------
import Localization from 'imba-localization'
const loc = new Localization('http://127.0.0.1:5501/localization.json')

loc.onready = do
	console.log loc['bonuses']['bonus1']

css
	# $accent: #007AFF
	body
		bgc: $base0
	.block bd:1px solid $gray2 rd:8px p:20px
	.example bg:$gray2 px:20px py:10px rd:5px fs:12px mt:20px
	.button d:hflex ai:center w:fit-content bg:$base8 rd:5px px:10px py:8px fill:white cursor:pointer c:white bxs@hover:0 0 10px $base8
	.link d:hflex ai:center w:fit-content bg:transparent bd:1px solid $gray3 rd:5px px:10px py:8px fill:$base0 cursor:pointer c:white bxs@hover:0 0 10px $gray10 c:$gray18
	.bonus 
		d:hflex ai:center fs:12px mt:10px
		@before
			content: '✓' c:white fw:bold mr:10px lh:20px fs:9px
			rd:50% bgc:green w:15px h:18px ta:center scale-y:0.8 y:1px
	
tag App
	hue1 = 40
	hue2 = 140
	hue3 = 240

	col1 = '#8b07ff'
	col2 = '#59ff07'
	col3 = '#1b00e6'

	<self>

		# header
		<div>
			css d:hflex ai:center h:60px px:20px bgc:$base2
			<svg src=ICONS.CODE>
				css w:30px fill:$accent
			<div> 'Imba Starter Kit'
				css fs:20px fw:500 ml:5px
			
			<div.button @click=(window.open('https://github.com/HeapVoid/bun-imba-template'))>
				css ml:auto
				<GithubIcon>
					css w:22px
				<div> 'Clone project'
					css ml:10px fs:14px
		
		# hero
		<div>
			css w:100% d:vflex ai:center jc:center py:40px bgc:$base1 # background:linear-gradient(180deg, $base2 0%, $base2 100%)
			<div> 'Launch Your Imba Project with Everything You Need'
				css fs:30px w:600px ta:center fw:600
			<div> 'This is a Bun template for creating Imba projects with batteries included — a comprehensive set of tools to help you get started. However, all the libraries can be used independently in any Imba project.'
				css fs:15px w:600px ta:center mt:20px

		# showroom
		<div>
			css d:grid gta:"theme localization" "notifications popups" gap:20px px:60px py:40px w:900px mx:auto
			
			# Color Schemes
			<div.block [ga:theme]>
				<Header title='Color Modes' subtitle='Seemless dark/light mode switching' icon=ICONS.MOON size='< 8KB'>
				<div.example [mb:20px]> 'bun add imba-color-modes'
				<div.bonus> 'Automantic system color mode detection'
				<div.bonus> 'Storing user preferencies in local storage'
				<div.bonus> 'Easy themes through automated palletes'
				<div.bonus> 'Plug and play mode switching components'
				<div.example> "See it in action"	
					css fs:12px fw:bold px:10px pb:10px
					<div>
						css bg:$base0 p:20px rd:5px mt:10px d:hflex ai:center jc:center
						<div @click=theme!>
							css bgc:light-dark(#000000/10, #FFFFFF/20) w:36px h:36px p:8px rd:6px d:inline-flex jc:center cursor:pointer fill:light-dark(#000000, #FFFFFF) bgc@hover:light-dark(#000000/20, #FFFFFF/30)
							<svg viewBox="0 0 256 256" xmlns="http://www.w3.org/2000/svg">
								<path d="M224,48V96a8,8,0,0,1-8,8H168a8,8,0,0,1-5.66-13.66L180.65,72a79.48,79.48,0,0,0-54.72-22.09h-.45A79.52,79.52,0,0,0,69.59,72.71,8,8,0,0,1,58.41,61.27,96,96,0,0,1,192,60.7l18.36-18.36A8,8,0,0,1,224,48ZM186.41,183.29A80,80,0,0,1,75.35,184l18.31-18.31A8,8,0,0,0,88,152H40a8,8,0,0,0-8,8v48a8,8,0,0,0,13.66,5.66L64,195.3a95.42,95.42,0,0,0,66,26.76h.53a95.36,95.36,0,0,0,67.07-27.33,8,8,0,0,0-11.18-11.44Z">
						<ColorSchemeSwitcher engine=cs>
							css mx:auto
						<ColorModeSwitcherSimple engine=cs>		
						#	css bg:$base0 rd:6px cursor:default fill:$base12
				<div>
					css d:hflex ai:center jc:center mt:20px
					<div.link @click=(window.open('https://www.npmjs.com/package/imba-color-scheme'))>
						<NpmIcon>
							css w:22px c:$gray14
						<div> 'Package'
							css ml:10px fs:14px
					<div.button @click=(window.open('https://github.com/HeapVoid/imba-color-scheme'))>
						css ml:auto
						<GithubIcon>
							css w:22px
						<div> 'Repository'
							css ml:10px fs:14px
						
			# Localization
			<div.block [ga:localization]>
				<Header title='Localization' subtitle='Simple, yet powerful localization' icon=ICONS.GLOBE size='< 1KB'>
				<div.example [mb:20px]> 'bun add imba-localization'
				<div.bonus> 'Automatic browser language detection'
				<div.bonus> 'Localization file (JSON) loaded asynchronously'
				<div.bonus> 'Single translation file with nested keys'
				<div.bonus> 'Plug and play component to switch languages'
				<div.example> "See it in action"
					css fs:12px fw:bold px:10px pb:10px
					<div>
						css h:84px bgc:$base0 rd:5px mx:auto w:100% mt:10px

				<div>
					css d:hflex ai:center jc:center mt:20px
					<div.link @click=(window.open('https://www.npmjs.com/package/imba-localization-loader'))>
						<NpmIcon>
							css w:22px c:$gray14
						<div> 'Package'
							css ml:10px fs:14px
					<div.button @click=(window.open('https://github.com/HeapVoid/imba-localization-loader'))>
						css ml:auto
						<GithubIcon>
							css w:22px
						<div> 'Repository'
							css ml:10px fs:14px

			<div.block [ga:notifications]>
				<Header title='Notifications' subtitle='Beautiful, customizable notifications' icon=ICONS.BELL size='< 1KB'>

			<div.block [ga:popups]>
				<Header title='Popups' subtitle='Easy and flexible popup system' icon=ICONS.APP_WINDOW size='< 1KB'>
		
		# footer
		<div>
			css h:100px w:100% bg:$gray1
		

imba.mount <App>