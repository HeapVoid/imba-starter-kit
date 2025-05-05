export tag Header
	title
	subtitle
	icon
	size

	<self>
		css d:vflex
		
		# header
		<div>
			css d:hflex ai:center
			<div>
				css bgc:$base2 p:5px rd:5px
				<svg src=icon>
					css w:26px fill:$base8
			<div>
				css d:vflex w:100%
				<div>
					css d:hflex ai:center
					<div> title
						css fs:16px ml:10px fw:bold
					<div> size
						css bg:$gray4 rd:8px ml:auto px:5px py:2px fs:10px
				<div> subtitle
					css fs:12px ml:10px

export tag LanguageSwitcher
	<self>