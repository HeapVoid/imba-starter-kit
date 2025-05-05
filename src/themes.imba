import * as ICONS from 'imba-phosphor-icons/filled'

export default tag Themes
	<self>
		css d:vflex
		
		# header
		<div>
			css d:hflex ai:center p:20px
			<div>
				css bg:$blue2 p:5px rd:5px
				<svg src=ICONS.MOON>
					css w:26px fill:$blue11
			<div>
				css d:vflex w:100%
				<div>
					css d:hflex ai:center
					<div> 'Color Schemes'
						css fs:16px ml:10px fw:bold
					<div> '< 1KB'
						css bg:$gray1 rd:10px ml:auto px:5px py:2px fs:12px
				<div> 'Seemless dark/light mode switching'
					css fs:12px ml:10px
			