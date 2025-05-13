import {Header, GitButton, NpmButton, icons} from './_components.imba'

# -------------------------------------
#  Color Modes infrastructure
# -------------------------------------
import {ColorModesState, ColorModeSwitcher, ColorModeSwitcherSimple, mix, pallete} from 'imba-color-modes'

const cs = new ColorModesState!
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
	pallete 'base', [mix(color,1,'#FFFFFF'), 18, mix(color,50,'#FFFFFF')], [mix(color,20,'#000000'), 18, mix(color,50,'#FFFFFF')]
	pallete 'accent', ['#FFFFFF', 8, color], [mix(color,50,'#000000'), 8 ,mix(color,80,'#FFFFFF')]
	pallete 'gray', [mix(mix(color,4,'#FFFFFF'),90,'#a8a8a8'), 8, '#a8a8a8'], [mix(mix(color,10,'#000000'),90,'#a8a8a8'), 8, '#a8a8a8']

theme(211)

# -------------------------------------
#  Localization infrastructure
# -------------------------------------
import { LocalizationState, LocalizationSelector } from 'imba-localization'
const loc = new LocalizationState('localization.json')

loc.onready = do
	imba.mount <App>

loc.onchange = do
	notify.hint = loc['notifications']['progress']

# -------------------------------------
#  Notifications infrastructure
# -------------------------------------
import { NotificationsState, NotificationsShow } from 'imba-notifications'

const notify = new NotificationsState(imba.commit)
imba.mount <NotificationsShow state=notify>

# -------------------------------------
#  Popups infrastructure
# -------------------------------------
import {PopupForm, PopupConfirm} from 'imba-popups'

# -------------------------------------
tag PopupFormCustom < PopupForm
	buttons = [
		{caption: loc['popups']['custom']['cancel']}
		{caption: loc['popups']['custom']['save'], callback: save.bind(self), primary: true}
	]
	
	username = 'John Doe'
	password = '123456'

	def save
		console.log 'Credentials are saved:', username, password
		return true

	def setup
		content = 
			<div [d:vflex]>
				<div.content-header> loc['popups']['custom']['header']
				<div.content-text> loc['popups']['custom']['text']
					css mb:15px
				<input.content-input bind=username>
					css w:100%
				<input.content-input bind=password type='password'>
					css w:100% mt:5px

def customform
	imba.mount <PopupFormCustom>

# -------------------------------------
tag PopupConfirmSave < PopupConfirm
	header = loc['popups']['confirmation']['header']
	text = loc['popups']['confirmation']['text']
	buttons = [
		{caption: loc['popups']['confirmation']['cancel']}
		{caption: loc['popups']['confirmation']['confirm'], callback:self.confirm, primary:true}
	]

	def confirm
		console.log 'Confirmed by user'
		return true

def confirmation
	imba.mount <PopupConfirmSave>

# -------------------------------------
#  Main application
# -------------------------------------
tag App

	css
		body bgc: $base0
		.header
			d:hflex ai:center h:60px px:20px bgc:$base4 w:100%
			svg 
				w:30px fill:$accent9
			div
				fs:20px fw:500 ml:5px
		.hero
			w:100% d:vflex ai:center jc:center py:40px bgc:$base2 # background:linear-gradient(180deg, $base2 0%, $base2 100%)
			div
				fs:30px w:500px ta:center fw:600
			span
				fs:15px w:600px ta:center mt:20px
		.block bd:1px solid $gray3 rd:8px p:20px
		.example bg:$gray3 px:10px py:10px rd:5px fs:12px mt:20px fw:bold
		.playground bg:$base1 p:20px rd:5px mt:10px d:hflex ai:center jc:center h:84px
		.bonus 
			d:hflex ai:center fs:12px mt:10px
			@before
				content: '✓' c:white fw:bold mr:10px lh:20px fs:9px
				rd:50% bgc:green w:15px h:18px ta:center scale-y:0.8 y:1px
		.card-footer d:hcc mt:20px
		.simple-button
			cursor:pointer
			rd:6px py:5px px:10px h:30px
			bd:1px solid $gray3
			c:light-dark(black, white)
			bgc@hover:$gray3
			c.colored:black c.colored@hover:white
			bgc.green:green5 bc.green:green6 bgc.green@hover:green7 
			bgc.blue:blue5 bc.blue:blue6 bgc.blue@hover:blue7
			bgc.yellow:yellow5 bc.yellow:yellow6 bgc.yellow@hover:yellow7
			bgc.red:red5 bc.red:red6 bgc.red@hover:red7
		.icon
			cursor:pointer
			d:inline-flex jc:center
			w:36px h:36px p:8px rd:6px 
			fill:light-dark(#000000, #FFFFFF)
			bgc:light-dark(#000000/10, #FFFFFF/20)
			bgc@hover:light-dark(#000000/20, #FFFFFF/30)


	<self [o@off:0] ease>
		css jai:center

		# header
		<div.header>
			<{icons.code} [w:32px fill:$accent9]>
			<div> 'Imba Starter Kit'
			<GitButton [ml:auto] caption=loc['main']['repository'] url='https://github.com/HeapVoid/bun-imba-template'>
		
		# hero
		<div.hero>
			<div> loc['main']['header']
			<span> loc['main']['subheader']

		# showroom
		<div>
			css d:grid gap:20px px:60px py:40px w:100% < 1200px
				gtc: 1fr 1fr
				gtr: 1fr 1fr
			
			# Color Modes
			<div.block> # [ga:colormodes]
				<Header title=loc['colormodes']['title'] subtitle=loc['colormodes']['subtitle'] icon=icons.moon size='< 9KB'>
				<div.example [mb:20px]> 'bun add imba-color-modes'
				<div.bonus> loc['colormodes']['bonus1']
				<div.bonus> loc['colormodes']['bonus2']
				<div.bonus> loc['colormodes']['bonus3']
				<div.bonus> loc['colormodes']['bonus4']
				<div.example> loc['main']['playground']
					<div.playground>
						<div.icon @click=theme!>
							<svg viewBox="0 0 256 256" xmlns="http://www.w3.org/2000/svg">
								<path d="M224,48V96a8,8,0,0,1-8,8H168a8,8,0,0,1-5.66-13.66L180.65,72a79.48,79.48,0,0,0-54.72-22.09h-.45A79.52,79.52,0,0,0,69.59,72.71,8,8,0,0,1,58.41,61.27,96,96,0,0,1,192,60.7l18.36-18.36A8,8,0,0,1,224,48ZM186.41,183.29A80,80,0,0,1,75.35,184l18.31-18.31A8,8,0,0,0,88,152H40a8,8,0,0,0-8,8v48a8,8,0,0,0,13.66,5.66L64,195.3a95.42,95.42,0,0,0,66,26.76h.53a95.36,95.36,0,0,0,67.07-27.33,8,8,0,0,0-11.18-11.44Z">
						<ColorModeSwitcher state=cs>
							css mx:auto
						<ColorModeSwitcherSimple state=cs>		
				<div.card-footer>
					<NpmButton caption=loc['main']['package'] url='https://www.npmjs.com/package/imba-color-modes'>
					<GitButton [ml:auto] caption=loc['main']['more'] url='https://github.com/HeapVoid/imba-color-modes'>

			# Localization
			<div.block> # [ga:localization]
				<Header title=loc['localization']['title'] subtitle=loc['localization']['subtitle'] icon=icons.globe size='< 4KB'>
				<div.example [mb:20px]> 'bun add imba-localization'
				<div.bonus> loc['localization']['bonus1']
				<div.bonus> loc['localization']['bonus2']
				<div.bonus> loc['localization']['bonus3']
				<div.bonus> loc['localization']['bonus4']
				<div.example> loc['main']['playground']
					<div.playground>
						<LocalizationSelector state=loc>
				<div.card-footer>
					<NpmButton caption=loc['main']['package'] url='https://www.npmjs.com/package/imba-localization'>
					<GitButton [ml:auto] caption=loc['main']['more'] url='https://github.com/HeapVoid/imba-localization'>
			
			<div.block> # [ga:notifications]
				<Header title=loc['notifications']['title'] subtitle=loc['notifications']['subtitle'] icon=icons.bell size='< 7KB'>
				<div.example [mb:20px]> 'bun add imba-notifications'
				<div.bonus> loc['notifications']['bonus1']
				<div.bonus> loc['notifications']['bonus2']
				<div.bonus> loc['notifications']['bonus3']
				<div.bonus> loc['notifications']['bonus4']
				<div.example> loc['main']['playground']
					<div.playground [gap:10px fw:500 fs:13px]>
						<div.simple-button.colored.green @click=notify.success(loc['notifications']['success']['header'], loc['notifications']['success']['text'])> loc['notifications']['success']['button']
						<div.simple-button.colored.blue @click=notify.info(loc['notifications']['info']['header'], loc['notifications']['info']['text'], 'Set the environment variable NODE_ENV to production, to run the app in production mode.')> loc['notifications']['info']['button']
						<div.simple-button.colored.yellow @click=notify.caution(loc['notifications']['caution']['header'], loc['notifications']['caution']['text'])> loc['notifications']['caution']['button']
						<div.simple-button.colored.red @click=notify.error(loc['notifications']['error']['header'], loc['notifications']['error']['text'], 'Set the environment variable NODE_ENV to production, to run the app in production mode.')> loc['notifications']['error']['button']
					
				<div.card-footer>
					<NpmButton caption=loc['main']['package'] url='https://www.npmjs.com/package/imba-notifications'>
					<GitButton [ml:auto] caption=loc['main']['more'] url='https://github.com/HeapVoid/imba-notifications'>

			# ###	
			<div.block> # [ga:popups]>
				<Header title=loc['popups']['title'] subtitle=loc['popups']['subtitle'] icon=icons.window size='< 3KB'>
				<div.example [mb:20px]> 'bun add imba-popups'
				<div.bonus> loc['popups']['bonus1']
				<div.bonus> loc['popups']['bonus2']
				<div.bonus> loc['popups']['bonus3']
				<div.bonus> loc['popups']['bonus4']
				<div.example> loc['main']['playground']
					<div.playground [gap:10px fw:500 fs:13px]>
						<div.simple-button @click=confirmation> loc['popups']['confirmation']['button']
						<div.simple-button @click=customform> loc['popups']['custom']['button']

				<div.card-footer>
					<NpmButton caption=loc['main']['package'] url='https://www.npmjs.com/package/imba-popups'>
					<GitButton [ml:auto] caption=loc['main']['more'] url='https://github.com/HeapVoid/imba-popups'>

		# footer
		<div>
			css w:100% bg:$gray1 px:40px py:40px d:vcc
			<div [d:hcc]>
				<div [fs:26px fw:100 mr:5px]> loc['main']['builtwith']
				<div [d:hcc cursor:pointer c@hover:amber4] @click=(window.open('https://imba.io'))>
					<img [w:30px mr:2px] src=String("/favicon.svg")>
					<div [fs:26px fw:700]> "Imba"
			<div [mt:5px fs:12px c:light-dark(black/40, white/40) fw:300]> "© 2025 Heap Void"

		

