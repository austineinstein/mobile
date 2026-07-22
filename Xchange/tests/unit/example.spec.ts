import { flushPromises, mount } from '@vue/test-utils'
import Tab1Page from '@/views/Tab1Page.vue'
import { beforeEach, describe, expect, test, vi } from 'vitest'

describe('Tab1Page.vue', () => {
  beforeEach(() => {
    vi.stubGlobal('fetch', vi.fn().mockResolvedValue({
      ok: true,
      json: async () => ({
        outAmount: '1000000',
        minOutAmount: '990000',
        estimatedGas: '210000',
        priceImpact: '0.02',
        route: [{ name: 'OpenOcean' }]
      })
    }))
  })

  test('renders a swap form and previews a quote', async () => {
    const wrapper = mount(Tab1Page)

    expect(wrapper.text()).toContain('Finance Swap')

    const amountInput = wrapper.find('input[placeholder="Enter amount"]')
    await amountInput.setValue('1')

    await wrapper.get('button').trigger('click')
    await flushPromises()

    expect(fetch).toHaveBeenCalled()
    expect(wrapper.text()).toContain('Quote ready')
  })
})
